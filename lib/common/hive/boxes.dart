// Third Party Packages
import 'package:hive/hive.dart';

// Project Modules
import 'package:livi_bank_test/common/model/phone_validation_result.dart';

class Boxes {
  static final _boxes = Boxes._internal();
  Boxes._internal();
  factory Boxes() => _boxes;

  static Box<PhoneValidationResult> getPhoneValidationResult() =>
      Hive.box<PhoneValidationResult>('PhoneValidationResult');
}
