// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'over_charge_record_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OverChargeRecordDataAdapter extends TypeAdapter<OverChargeRecordData> {
  @override
  final int typeId = 1;

  @override
  OverChargeRecordData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OverChargeRecordData(
      phone: fields[0] as String,
      previousMessage: fields[1] as String,
      currentMessage: fields[2] as String,
      overCharge: fields[3] as double,
      date: fields[4] as DateTime,
      amount: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OverChargeRecordData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.phone)
      ..writeByte(1)
      ..write(obj.previousMessage)
      ..writeByte(2)
      ..write(obj.currentMessage)
      ..writeByte(3)
      ..write(obj.overCharge)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverChargeRecordDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
