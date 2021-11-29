import 'package:formz/formz.dart';

enum PronomValidationError { invalid }

class Pronom extends FormzInput<String, PronomValidationError> {
  const Pronom.pure([String value = '']) : super.pure(value);
  const Pronom.dirty([String value = '']) : super.dirty(value);

  @override
  PronomValidationError? validator(String? value) {
    return value != null ? null : PronomValidationError.invalid;
  }
}
