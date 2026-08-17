import 'package:bank_chargez/over_charge_record_data.dart';
import 'package:hive/hive.dart';

class OverchargePeriodSummary {
  final double total;
  final int count;

  OverchargePeriodSummary({
    required this.total,
    required this.count,
  });
}

class OverchargeCalculator {
  static const String boxName = 'overCharges';

  // static List<OverChargeRecordData> get records {
  //   final box = Hive.box<OverChargeRecordData>(boxName);

  //   return box.values.toList();

  // }

  static List<OverChargeRecordData> recordsForPhone(
  String phone,
) {
  final box = Hive.box<OverChargeRecordData>(boxName);

  return box.values
      .where((record) => record.phone == phone)
      .toList();
}

  static OverchargePeriodSummary today(String phone) {
    final now = DateTime.now();
    final records = recordsForPhone(phone);

    final filtered = records.where((record) {
      return record.date.year == now.year &&
          record.date.month == now.month &&
          record.date.day == now.day;
    }).toList();

    return _summary(filtered);
  }

  static OverchargePeriodSummary week(String phone) {
    final now = DateTime.now();

    final startOfWeek =
        now.subtract(Duration(days: now.weekday - 1));

    final start = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );

    final end = start.add(const Duration(days: 7));
    final records = recordsForPhone(phone);

    final filtered = records.where((record) {
      return !record.date.isBefore(start) &&
          record.date.isBefore(end);
    }).toList();

    return _summary(filtered);
  }

  static OverchargePeriodSummary month(String phone) {
    final now = DateTime.now();
    final records = recordsForPhone(phone);

    final filtered = records.where((record) {
      return record.date.year == now.year &&
          record.date.month == now.month;
    }).toList();

    return _summary(filtered);
  }

  static OverchargePeriodSummary year(String phone) {
    final now = DateTime.now();
    final records = recordsForPhone(phone);
    final filtered = records.where((record) {
      return record.date.year == now.year;
    }).toList();

    return _summary(filtered);
  }

  static OverchargePeriodSummary _summary(
    List<OverChargeRecordData> records,
  ) {
    return OverchargePeriodSummary(
      total: records.fold(
        0.0,
        (sum, record) => sum + record.overCharge,
      ),
      count: records.length,
    );
  }
}