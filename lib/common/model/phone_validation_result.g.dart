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
      code: fields[1] as String?,
      name: fields[2] as String?,
      dialCode: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      isValid: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneValidationResult obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.createdDate)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dialCode)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.isValid);
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
