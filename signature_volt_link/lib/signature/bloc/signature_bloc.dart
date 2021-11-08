import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:confetti/confetti.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:signature_volt_link/signature/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'signature_event.dart';
part 'signature_state.dart';

class SignatureBloc extends Bloc<SignatureEvent, SignatureState> {
  SignatureBloc() : super(const SignatureState()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<LocationChanged>(_onLocationChanged);
    on<PositionChanged>(_onPositionChanged);
    on<PronomChanged>(_onPronomChanged);

    on<NameUnfocused>(_onNameUnfocused);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<LocationUnfocused>(_onLocationUnfocused);
    on<PositionUnfocused>(_onPositionUnfocused);
    on<PronomUnfocused>(_onPronomUnfocused);

    on<FormSubmitted>(_onFormSubmitted);
  }

  @override
  void onTransition(Transition<SignatureEvent, SignatureState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  var confettiController =
      ConfettiController(duration: const Duration(milliseconds: 500));

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  bool isScreenWide(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 900) {
      return true;
    }
    return false;
  }

  Future<String> loadSignature() async {
    return await rootBundle.loadString('assets/html/signature.txt');
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  void _onNameChanged(NameChanged event, Emitter<SignatureState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name.valid ? name : Name.pure(event.name),
      status: Formz.validate([name, state.email]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignatureState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status: Formz.validate([email, state.name]),
    ));
  }

  void _onLocationChanged(LocationChanged event, Emitter<SignatureState> emit) {
    final location = Location.dirty(event.location);
    emit(state.copyWith(
      location: location.valid ? location : Location.pure(event.location),
      status: Formz.validate([location, state.email]),
    ));
  }

  void _onPositionChanged(PositionChanged event, Emitter<SignatureState> emit) {
    final position = Position.dirty(event.position);
    emit(state.copyWith(
      position: position.valid ? position : Position.pure(event.position),
      status: Formz.validate([position, state.email]),
    ));
  }

  void _onPronomChanged(PronomChanged event, Emitter<SignatureState> emit) {
    final pronom = Pronom.dirty(event.pronom);
    emit(state.copyWith(
      pronom: pronom.valid ? pronom : Pronom.pure(event.pronom),
      status: Formz.validate([pronom, state.email]),
    ));
  }

  void _onNameUnfocused(NameUnfocused event, Emitter<SignatureState> emit) {
    final name = Name.dirty(state.email.value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.name]),
    ));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<SignatureState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.name]),
    ));
  }

  void _onLocationUnfocused(
      LocationUnfocused event, Emitter<SignatureState> emit) {
    final location = Location.dirty(state.location.value);
    emit(state.copyWith(
      location: location,
      status: Formz.validate([location, state.name]),
    ));
  }

  void _onPositionUnfocused(
      PositionUnfocused event, Emitter<SignatureState> emit) {
    final positon = Position.dirty(state.position.value);
    emit(state.copyWith(
      position: positon,
      status: Formz.validate([positon, state.name]),
    ));
  }

  void _onPronomUnfocused(PronomUnfocused event, Emitter<SignatureState> emit) {
    final pronom = Pronom.dirty(state.email.value);
    emit(state.copyWith(
      pronom: pronom,
      status: Formz.validate([pronom, state.name]),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SignatureState> emit) async {
    final name = state.name;
    final email = state.email;
    emit(state.copyWith(
      name: name,
      email: email,
      status: Formz.validate([name, email]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
