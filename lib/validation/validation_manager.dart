import 'package:livi_bank_test/common/hive/boxes.dart';
import 'package:livi_bank_test/common/model/phone_validation_result.dart';
import 'package:livi_bank_test/home/util/phone_notifier.dart';

class ValidationManager {
  static final ValidationManager _manager = ValidationManager._internal();
  ValidationManager._internal();
  factory ValidationManager() => _manager;

  static Future<void> addValidation() async {
    PhoneNotifier notifier = PhoneNotifier();
    final result = PhoneValidationResult()
      ..createdDate = DateTime.now()
      ..code = notifier.countryCode.code
      ..name = notifier.countryCode.name
      ..dialCode = notifier.countryCode.dialCode
      ..phoneNumber = notifier.phoneNum.value
      ..isValid = notifier.isValid;
    final box = Boxes.getPhoneValidationResult();
    box.add(result);
  }
}
