import 'package:formz/formz.dart';

enum LocationValidationError { invalid }

class Location extends FormzInput<String, LocationValidationError> {
  const Location.pure([String value = '']) : super.pure(value);
  const Location.dirty([String value = '']) : super.dirty(value);

  @override
  LocationValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : LocationValidationError.invalid;
  }
}
