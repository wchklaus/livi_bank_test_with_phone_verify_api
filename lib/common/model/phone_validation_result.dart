// Third Party Packages
import 'package:hive/hive.dart';

part 'phone_validation_result.g.dart';

@HiveType(typeId: 0)
class PhoneValidationResult extends HiveObject {
  @HiveField(0)
  late DateTime? createdDate;
  @HiveField(1)
  late bool isValid;
  @HiveField(2)
  late String? number;
  @HiveField(3)
  late String? localFormat;
  @HiveField(4)
  late String? internationalFormat;
  @HiveField(5)
  late String? countryPrefix;
  @HiveField(6)
  late String? countryCode;
  @HiveField(7)
  late String? countryName;
  @HiveField(8)
  late String? location;
  @HiveField(9)
  late String? carrier;
  @HiveField(10)
  late String? lineType;

  PhoneValidationResult({
    this.createdDate,
    this.isValid = false,
    this.number,
    this.localFormat,
    this.internationalFormat,
    this.countryPrefix,
    this.countryCode,
    this.countryName,
    this.location,
    this.carrier,
    this.lineType,
  });

  PhoneValidationResult.fromJson(Map<String, dynamic> json) {
    createdDate = DateTime.now();
    isValid =
        json['valid'] == true && json['line_type'] == 'mobile' ? true : false;
    number = json['number'];
    localFormat = json['local_format'];
    internationalFormat = json['international_format'];
    countryPrefix = json['country_prefix'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    location = json['location'];
    carrier = json['carrier'];
    lineType = json['line_type'];
  }

  String toString() {
    return "{valid: $isValid, number: $number, label_format: $localFormat, international_format: $internationalFormat, country_prefix: $countryPrefix,  country_code: $countryCode, country_name: $countryName, location: $location, carrier: $carrier, line_type: $lineType}";
  }
}
