import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:confetti/confetti.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:signature_volt_link/signature/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

part 'signature_event.dart';
part 'signature_state.dart';

enum FormField { name, email, location, position }

class SignatureBloc extends Bloc<SignatureEvent, SignatureState> {
  SignatureBloc(
      [String? memberName,
      String? mailAddress,
      String? location,
      String? position])
      : _memberName = memberName,
        _mailAddress = mailAddress,
        _location = location,
        _position = position,
        super(const SignatureState()) {
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

  final String? _memberName;
  final String? _mailAddress;
  final String? _location;
  final String? _position;

  final String defaultName = 'Jean Placeholder';
  final String defaultMailAdress = 'jean.placeholder@volteuropa.org';
  final String defaultLocation = 'Deutschland';
  final String defaultPosition = 'DE Placeholder';

  @override
  void onTransition(Transition<SignatureEvent, SignatureState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  var confettiController =
      ConfettiController(duration: const Duration(milliseconds: 500));
  var htmlEditorController = HtmlEditorController();

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

  String checkSignature(String signature) {
    if (state.name.value.isNotEmpty) {
      signature.replaceFirst(defaultName, state.name.value);
    }

    if (state.email.value.isNotEmpty) {
      signature.replaceAll(defaultMailAdress, state.email.value);
    }
    if (state.location.value.isNotEmpty) {
      signature.replaceFirst(defaultLocation, state.location.value);
    }
    if (state.position.value.isNotEmpty) {
      signature.replaceFirst(defaultPosition, state.position.value);
    }
    return signature;
  }

  Future<String> updateSignature(String value, FormField formField) async {
    var htmlSignature = await loadSignature();

    switch (formField) {
      case FormField.name:
        htmlSignature = htmlSignature.replaceFirst(defaultName, value);
        break;
      case FormField.email:
        htmlSignature = htmlSignature.replaceAll(defaultMailAdress, value);
        break;
      case FormField.location:
        htmlSignature = htmlSignature.replaceFirst(defaultLocation, value);
        break;
      case FormField.position:
        htmlSignature = htmlSignature.replaceFirst(defaultPosition, value);
        break;
      default:
    }
    if (state.name.value.isNotEmpty) {
      htmlSignature = htmlSignature.replaceFirst(defaultName, state.name.value);
    }
    if (state.email.value.isNotEmpty) {
      htmlSignature =
          htmlSignature.replaceAll(defaultMailAdress, state.email.value);
    }
    if (state.location.value.isNotEmpty) {
      htmlSignature =
          htmlSignature.replaceFirst(defaultLocation, state.location.value);
    }
    if (state.position.value.isNotEmpty) {
      htmlSignature =
          htmlSignature.replaceFirst(defaultPosition, state.position.value);
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
    updateHtmlEditor(htmlSignature);

    emit(state.copyWith(
      name: name.valid ? name : Name.pure(event.name),
      htmlSignature: htmlSignature,
      status:
          Formz.validate([name, state.email, state.location, state.position]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignatureState> emit) async {
    final email = Email.dirty(event.email);
    final htmlSignature = await updateSignature(email.value, FormField.email);
    updateHtmlEditor(htmlSignature);

    emit(state.copyWith(
      email: email.valid ? email : Email.pure(event.email),
      htmlSignature: htmlSignature,
      status:
          Formz.validate([email, state.name, state.location, state.position]),
    ));
  }

  void _onLocationChanged(
      LocationChanged event, Emitter<SignatureState> emit) async {
    final location = Location.dirty(event.location);
    final htmlSignature =
        await updateSignature(location.value, FormField.location);
    updateHtmlEditor(htmlSignature);

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
    updateHtmlEditor(htmlSignature);

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
    final name = Name.dirty(state.name.value);

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
      status:
          Formz.validate([position, state.email, state.name, state.location]),
    ));
  }

  void _onPronomUnfocused(PronomUnfocused event, Emitter<SignatureState> emit) {
    final pronom = Pronom.dirty(state.pronom.value);
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
    var htmlSignature = await loadSignature();

    var memberNameString = _memberName;
    memberNameString ??= defaultName;
    var memberName = Name.dirty(memberNameString);

    var mailAddressString = _mailAddress;
    mailAddressString ??= defaultMailAdress;
    var mailAddress = Email.dirty(memberNameString);

    var locationString = _location;
    locationString ??= defaultLocation;
    var location = Location.dirty(memberNameString);

    var positionString = _position;
    positionString ??= defaultPosition;
    var position = Position.dirty(positionString);

    htmlSignature = await updateSignature(memberName.value, FormField.name);
    htmlSignature = await updateSignature(mailAddress.value, FormField.email);
    htmlSignature = await updateSignature(location.value, FormField.location);
    htmlSignature = await updateSignature(position.value, FormField.position);
    updateHtmlEditor(htmlSignature);

    emit(state.copyWith(
      htmlSignature: htmlSignature,
      name: memberName,
      email: mailAddress,
      location: location,
      position: position,
    ));
  }

  void _onCopyMailSignature(
      CopyMailSignature event, Emitter<SignatureState> emit) async {
    // TODO: Open guide to embed the signature
  }

  void updateHtmlEditor(String html) {
    htmlEditorController.disable();
    htmlEditorController.clear();
    htmlEditorController.insertHtml(html);
  }
}
