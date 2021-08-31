import 'package:form_field_validator/form_field_validator.dart';

final RequiredValidator requiredValidator =
    RequiredValidator(errorText: 'This field is required');

final MultiValidator passwordValidator = MultiValidator([
  requiredValidator,
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
]);

final MatchValidator matchValidator =
    MatchValidator(errorText: 'Password must be match');

final MultiValidator emailValidator = MultiValidator([
  requiredValidator,
  EmailValidator(errorText: 'Enter a valid email address'),
]);
