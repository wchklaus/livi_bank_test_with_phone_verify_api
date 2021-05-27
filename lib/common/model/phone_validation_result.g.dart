// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_validation_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhoneValidationResultAdapter extends TypeAdapter<PhoneValidationResult> {
  @override
  final int typeId = 0;

  @override
  PhoneValidationResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhoneValidationResult(
      createdDate: fields[0] as DateTime?,
      isValid: fields[1] as bool,
      number: fields[2] as String?,
      localFormat: fields[3] as String?,
      internationalFormat: fields[4] as String?,
      countryPrefix: fields[5] as String?,
      countryCode: fields[6] as String?,
      countryName: fields[7] as String?,
      location: fields[8] as String?,
      carrier: fields[9] as String?,
      lineType: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneValidationResult obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.createdDate)
      ..writeByte(1)
      ..write(obj.isValid)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.localFormat)
      ..writeByte(4)
      ..write(obj.internationalFormat)
      ..writeByte(5)
      ..write(obj.countryPrefix)
      ..writeByte(6)
      ..write(obj.countryCode)
      ..writeByte(7)
      ..write(obj.countryName)
      ..writeByte(8)
      ..write(obj.location)
      ..writeByte(9)
      ..write(obj.carrier)
      ..writeByte(10)
      ..write(obj.lineType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneValidationResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
