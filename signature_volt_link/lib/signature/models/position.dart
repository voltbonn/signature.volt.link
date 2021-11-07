import 'package:formz/formz.dart';

enum PositionValidationError { invalid }

class Position extends FormzInput<String, PositionValidationError> {
  const Position.pure([String value = '']) : super.pure(value);
  const Position.dirty([String value = '']) : super.dirty(value);

  @override
  PositionValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : PositionValidationError.invalid;
  }
}
