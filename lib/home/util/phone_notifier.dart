import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:livi_bank_test/common/model/country.dart';

class ValidationItem {
  final String? value;
  final String? error;
  ValidationItem(this.value, this.error);
}

class PhoneNotifier extends ChangeNotifier {
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

  void setCountryCode(CountryCode code) {
    _countryCode = code;
    _phoneNum = ValidationItem(null, null);
    notifyListeners();
  }

  // Setters
  void changePhoneNum(String value) {
    print(countryCode.dialCode);
    if (Country.codeToCountryMap.containsKey(countryCode.dialCode)) {
      final country = Country.codeToCountryMap[countryCode.dialCode];
      String? mobilePrefix;
      country!.mobilePrefix.forEach((element) {
        if (mobilePrefix == null) {
          mobilePrefix = element;
        } else {
          mobilePrefix = mobilePrefix! + ",$element";
        }
      });
      RegExp regEXp = RegExp("^[$mobilePrefix]");
      bool isValidPhoneNum = regEXp.hasMatch(value);
      print(isValidPhoneNum);
      if (value.length == 8 && isValidPhoneNum) {
        _phoneNum = ValidationItem(value, null);
      } else {
        _phoneNum = ValidationItem(value, '手機格式號不正確，請檢查');
      }
      notifyListeners();
    } else {
      _phoneNum = ValidationItem(value, null);
    }
    notifyListeners();
  }
}
