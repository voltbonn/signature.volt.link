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
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, rootBundle;

part 'signature_event.dart';
part 'signature_state.dart';

enum FormField { name, email, location, position }

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
    on<LoadHtmlSignature>(_onLoadHtmlSignature);
    on<CopyMailSignature>(_onCopyMailSignature);
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

  Future<String> updateSignature(String value, FormField formField) async {
    var htmlSignatureOrg = await loadSignature();
    var htmlSignature = htmlSignatureOrg;
    switch (formField) {
      case FormField.name:
        htmlSignature =
            htmlSignatureOrg.replaceFirst('Jean Placeholder', value);
        break;
      case FormField.email:
        htmlSignature = htmlSignatureOrg.replaceFirst(
            'jean.placeholder@volteuropa.org', value);
        break;
      case FormField.location:
        htmlSignature = htmlSignatureOrg.replaceFirst(
            'Volt Europa / Volt Deutschland', value);
        break;
      case FormField.position:
        htmlSignature = htmlSignatureOrg.replaceFirst('DE Placholder', value);
        break;
      default:
    }

    return htmlSignature;
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

  void _onNameChanged(NameChanged event, Emitter<SignatureState> emit) async {
    final name = Name.dirty(event.name);
    final htmlSignature = await updateSignature(name.value, FormField.name);
    emit(state.copyWith(
      name: name.valid ? name : Name.pure(event.name),
      htmlSignature: htmlSignature,
      status:
          Formz.validate([name, state.email, state.location, state.position]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignatureState> emit) async {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      status:
          Formz.validate([email, state.name, state.location, state.position]),
    ));
  }

  void _onLocationChanged(
      LocationChanged event, Emitter<SignatureState> emit) async {
    final location = Location.dirty(event.location);
    final htmlSignature =
        await updateSignature(location.value, FormField.location);
    emit(state.copyWith(
      location: location.valid ? location : Location.pure(event.location),
      htmlSignature: htmlSignature,
      status:
          Formz.validate([location, state.name, state.email, state.position]),
    ));
  }

  void _onPositionChanged(
      PositionChanged event, Emitter<SignatureState> emit) async {
    final position = Position.dirty(event.position);
    final htmlSignature =
        await updateSignature(position.value, FormField.position);
    emit(state.copyWith(
      position: position.valid ? position : Position.pure(event.position),
      htmlSignature: htmlSignature,
      status: Formz.validate([
        position,
        state.email,
        state.name,
        state.location,
      ]),
    ));
  }

  void _onPronomChanged(PronomChanged event, Emitter<SignatureState> emit) {
    final pronom = Pronom.dirty(event.pronom);
    emit(state.copyWith(
      pronom: pronom.valid ? pronom : Pronom.pure(event.pronom),
      status: Formz.validate([
        pronom,
        state.email,
        state.name,
        state.email,
        state.position,
        state.location,
        state.pronom,
      ]),
    ));
  }

  void _onNameUnfocused(NameUnfocused event, Emitter<SignatureState> emit) {
    final name = Name.dirty(state.email.value);
    emit(state.copyWith(
      name: name,
      status:
          Formz.validate([name, state.email, state.location, state.position]),
    ));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<SignatureState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status:
          Formz.validate([email, state.name, state.location, state.position]),
    ));
  }

  void _onLocationUnfocused(
      LocationUnfocused event, Emitter<SignatureState> emit) {
    final location = Location.dirty(state.location.value);
    emit(state.copyWith(
      location: location,
      status:
          Formz.validate([location, state.name, state.email, state.position]),
    ));
  }

  void _onPositionUnfocused(
      PositionUnfocused event, Emitter<SignatureState> emit) {
    final position = Position.dirty(state.position.value);
    emit(state.copyWith(
      position: position,
      status: Formz.validate([
        position,
        state.email,
        state.name,
        state.location,
      ]),
    ));
  }

  void _onPronomUnfocused(PronomUnfocused event, Emitter<SignatureState> emit) {
    final pronom = Pronom.dirty(state.email.value);
    emit(state.copyWith(
      pronom: pronom,
      status: Formz.validate(
          [pronom, state.email, state.name, state.position, state.location]),
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

  void _onLoadHtmlSignature(
      LoadHtmlSignature event, Emitter<SignatureState> emit) async {
    final htmlSignature = await loadSignature();
    emit(state.copyWith(
      htmlSignature: htmlSignature,
    ));
  }

  void _onCopyMailSignature(
      CopyMailSignature event, Emitter<SignatureState> emit) async {
    await Clipboard.setData(ClipboardData(text: state.htmlSignature));
  }
}
