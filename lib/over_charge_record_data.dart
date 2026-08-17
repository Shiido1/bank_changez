import 'package:hive/hive.dart';

part 'over_charge_record_data.g.dart';

@HiveType(typeId: 1)
class OverChargeRecordData extends HiveObject {
  @HiveField(0)
  final String phone;

  @HiveField(1)
  final String previousMessage;

  @HiveField(2)
  final String currentMessage;

  @HiveField(3)
  final double overCharge;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final double amount;

  OverChargeRecordData({
    required this.phone,
    required this.previousMessage,
    required this.currentMessage,
    required this.overCharge,
    required this.date,
    required this.amount,
  });
}
