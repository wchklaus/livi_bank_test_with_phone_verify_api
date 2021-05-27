import 'package:hive/hive.dart';

part 'phone_validation_result.g.dart';

@HiveType(typeId: 0)
class PhoneValidationResult extends HiveObject {
  @HiveField(0)
  late DateTime? createdDate;
  @HiveField(1)
  late String? code;
  @HiveField(2)
  late String? name;
  @HiveField(3)
  late String? dialCode;
  @HiveField(4)
  late String? phoneNumber;
  @HiveField(5)
  late bool isValid;
  PhoneValidationResult({
    this.createdDate,
    this.code,
    this.name,
    this.dialCode,
    this.phoneNumber,
    this.isValid = false,
  });
}
