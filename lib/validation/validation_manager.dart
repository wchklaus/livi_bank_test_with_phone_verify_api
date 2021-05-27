// Project Modules
import 'package:livi_bank_test/common/hive/boxes.dart';
import 'package:livi_bank_test/common/model/phone_validation_result.dart';

class ValidationManager {
  static final ValidationManager _manager = ValidationManager._internal();
  ValidationManager._internal();
  factory ValidationManager() => _manager;

  static Future<void> addValidation(
      {required PhoneValidationResult result}) async {
    final box = Boxes.getPhoneValidationResult();
    box.add(result);
  }
}
