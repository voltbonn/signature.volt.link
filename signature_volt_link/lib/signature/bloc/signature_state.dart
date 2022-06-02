part of 'signature_bloc.dart';

class SignatureState extends Equatable {
  const SignatureState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.location = const Location.pure(),
    this.position = const Position.pure(),
    this.pronom = const Pronom.pure(),
    this.htmlSignature = "",
    this.status = FormzStatus.pure,
    required this.htmlEditorController,
  });

  final Name name;
  final Email email;
  final Location location;
  final Position position;
  final Pronom pronom; // TODO: String to enum
  final String htmlSignature;
  final FormzStatus status;
  final HtmlEditorController htmlEditorController;

  SignatureState copyWith({
    Name? name,
    Email? email,
    Location? location,
    Position? position,
    Pronom? pronom,
    String? htmlSignature,
    FormzStatus? status,
    HtmlEditorController? htmlEditorController,
  }) {
    return SignatureState(
        name: name ?? this.name,
        email: email ?? this.email,
        location: location ?? this.location,
        position: position ?? this.position,
        pronom: pronom ?? this.pronom,
        htmlSignature: htmlSignature ?? this.htmlSignature,
        status: status ?? this.status,
        htmlEditorController:
            htmlEditorController ?? this.htmlEditorController);
  }

  @override
  List<Object> get props =>
      [name, email, location, position, status, htmlEditorController];
}
