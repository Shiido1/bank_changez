import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import '../ui/utilities/color.dart';
import '../ui/utilities/over_charged_record.dart';
import '../ui/utilities/over_charged_summary.dart';

class SmsChatScreen extends StatefulWidget {
  final String phone;
  const SmsChatScreen({super.key, required this.phone});

  @override
  State<SmsChatScreen> createState() => _SmsChatScreenState();
}

class _SmsChatScreenState extends State<SmsChatScreen> {
  final Telephony telephony = Telephony.instance;
  List<OverChargeRecord> overCharges = [];

  List<SmsMessage> chats = [];

  @override
  void initState() {
    loadConversation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(widget.phone,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20.4,
            )),
        backgroundColor: AppColors.greyWell,
      ),
      body: ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(vertical: 30),
          itemCount: chats.length,
          itemBuilder: (context, index) {
            double? overCharge;
            final sms = chats[chats.length - 1 - index];
            final current = chats[chats.length - 1 - index];

            if (index < chats.length - 1) {
              final prev = chats[chats.length - 2 - index];
              overCharge = calculateOverCharge(
                previousSms: prev.body!,
                currentSms: current.body!,
              );
            }
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(86, 51, 54, 106),
                        border: Border.all(color: AppColors.white1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      sms.body ?? '',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (overCharge != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade300.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Overcharged: ₦${overCharge.toStringAsFixed(2)} ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
    );
  }

  double? calculateOverCharge({
    required String previousSms,
    required String currentSms,
  }) {
    final previousBalance = extractBalance(previousSms);
    final currentBalance = extractBalance(currentSms);

    final amount = extractAmount(currentSms);

    final expected = expectedCharge(amount);

    final expectedBalance;

    double difference = 0;
    if (currentSms
            .toString()
            .substring(0, 5)
            .toLowerCase()
            .contains('credit') ||
        currentSms.toString().substring(0, 5).toLowerCase().contains('debit')) {
      if (currentSms.toString().substring(0, 5).toLowerCase() == 'credit') {
        expectedBalance = previousBalance + amount;
        difference = (expectedBalance - currentBalance);
      } else {
        expectedBalance = previousBalance - amount - expected;
        difference = (expectedBalance - currentBalance);
      }
    }

    if (difference > 0.01) {
      return difference;
    }

    return null;
  }

  double expectedCharge(double amount) {
    if (amount < 5000) {
      return 0;
    } else if (amount < 50000) {
      return 10;
    } else {
      return 50;
    }
  }

  double extractAmount(String body) {
    final match = RegExp(r'Amt:\s*NGN([\d,]+\.\d{2})').firstMatch(body);
    if (match == null) return 0;

    return double.parse(match.group(1)!.replaceAll(',', ''));
  }

  double extractBalance(String body) {
    final match = RegExp(r'Bal:\s*NGN([\d,]+\.\d{2})').firstMatch(body);
    if (match == null) return 0;

    return double.parse(match.group(1)!.replaceAll(',', ''));
  }

  Future<void> loadConversation() async {
    final allMessages = await telephony.getInboxSms(columns: [
      SmsColumn.ID,
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
      SmsColumn.DATE,
      SmsColumn.THREAD_ID,
    ], sortOrder: [
      OrderBy(SmsColumn.DATE, sort: Sort.ASC),
    ]);

    final messages = allMessages.where((sms) {
      return sms.address == widget.phone;
    }).toList();

    setState(() {
      chats = messages;
    });

    calculateAllOverCharges();
  }

  void calculateAllOverCharges() {
    overCharges.clear();

    for (int i = 1; i < chats.length; i++) {
      final previous = chats[i - 1];
      final current = chats[i];

      final charge = calculateOverCharge(
        previousSms: previous.body!,
        currentSms: current.body!,
      );

      if (charge != null) {
        overCharges.add(
          OverChargeRecord(
            amount: charge,
            date: DateTime.fromMillisecondsSinceEpoch(current.date!),
          ),
        );
      }
    }
  }

  OverChargeSummary getSummary(Duration duration) {
    final now = DateTime.now();

    final filtered = overCharges.where((item) {
      return item.date.isAfter(now.subtract(duration));
    }).toList();

    return OverChargeSummary(
      total: filtered.fold(
        0.0,
        (sum, item) => sum + item.amount,
      ),
      count: filtered.length,
    );
  }

  OverChargeSummary monthSummary() {
    final now = DateTime.now();

    final filtered = overCharges.where((e) {
      return e.date.year == now.year && e.date.month == now.month;
    }).toList();

    return OverChargeSummary(
      total: filtered.fold(
        0.0,
        (sum, e) => sum + e.amount,
      ),
      count: filtered.length,
    );
  }

  OverChargeSummary yearSummary() {
    final now = DateTime.now();

    final filtered = overCharges.where((e) {
      return e.date.year == now.year;
    }).toList();

    return OverChargeSummary(
      total: filtered.fold(
        0.0,
        (sum, e) => sum + e.amount,
      ),
      count: filtered.length,
    );
  }
}
