// Flutter Packages
import 'package:flutter/material.dart';

// Customized Packages
import 'package:country_code_picker/country_code_picker.dart';

// Project Modules
import 'package:livi_bank_test/common/model/phone_validation_result.dart';
import 'package:livi_bank_test/validation/validation_manager.dart';
import 'package:livi_bank_test/validation/validation_page.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class PhoneNotifier {
  static CountryCode _countryCode = CountryCode(
    name: "Hong Kong",
    code: "HK",
    dialCode: "+852",
  );
  static ValidationItem _phoneNum = ValidationItem(null, null);

  // Getters
  ValidationItem get phoneNum => _phoneNum;
  CountryCode get countryCode => _countryCode;

  bool get isValid {
    return _phoneNum.error == null && _phoneNum.value != null ? true : false;
  }

  void setCountryCode(CountryCode code, Function setState) {
    _countryCode = code;
    _phoneNum = ValidationItem(null, null);
    setState();
  }

  // Setters
  void changePhoneNum(
      BuildContext context, Map<String, dynamic> value, Function setState) {
    PhoneValidationResult validationResult =
        PhoneValidationResult.fromJson(value);
    ValidationManager.addValidation(result: validationResult);
    if (validationResult.isValid) {
      _phoneNum = ValidationItem(validationResult.localFormat, null);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ValidationPage();
          },
        ),
      );
    } else {
      _phoneNum = ValidationItem(validationResult.localFormat, '手機格式號不正確，請檢查');
    }
    setState();
  }
}
