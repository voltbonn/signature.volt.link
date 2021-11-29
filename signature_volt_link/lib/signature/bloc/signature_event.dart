part of 'signature_bloc.dart';

abstract class SignatureEvent extends Equatable {
  const SignatureEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends SignatureEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameUnfocused extends SignatureEvent {}

class EmailChanged extends SignatureEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends SignatureEvent {}

class LocationChanged extends SignatureEvent {
  const LocationChanged({required this.location});

  final String location;

  @override
  List<Object> get props => [location];
}

class LocationUnfocused extends SignatureEvent {}

class PositionChanged extends SignatureEvent {
  const PositionChanged({required this.position});

  final String position;

  @override
  List<Object> get props => [position];
}

class PositionUnfocused extends SignatureEvent {}

class PronomChanged extends SignatureEvent {
  const PronomChanged({required this.pronom});

  final String pronom;

  @override
  List<Object> get props => [pronom];
}

class PronomUnfocused extends SignatureEvent {}

class FormSubmitted extends SignatureEvent {}

class LoadHtmlSignature extends SignatureEvent {}

class CopyMailSignature extends SignatureEvent {}
