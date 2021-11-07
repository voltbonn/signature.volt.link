part of 'signature_bloc.dart';

class SignatureState extends Equatable {
  const SignatureState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.location = const Location.pure(),
    this.position = const Position.pure(),
    this.pronom = const Pronom.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Email email;
  final Location location;
  final Position position;
  final Pronom pronom; // TODO: String to enum
  final FormzStatus status;

  SignatureState copyWith({
    Name? name,
    Email? email,
    Location? location,
    Position? position,
    Pronom? pronom,
    FormzStatus? status,
  }) {
    return SignatureState(
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      position: position ?? this.position,
      pronom: pronom ?? this.pronom,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, email, location, position, pronom];
}
