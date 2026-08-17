// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:telephony/telephony.dart';

import '../over_charge_record_data.dart';
import '../ui/utilities/color.dart';
import '../ui/utilities/over_charged_summary.dart';
import '../ui/widgets/unlawful_over_charged_card.dart';
import 'saved_over_charges_screen.dart';

class SmsChatScreen extends StatefulWidget {
  final String phone;
  const SmsChatScreen({super.key, required this.phone});

  @override
  State<SmsChatScreen> createState() => _SmsChatScreenState();
}

class _SmsChatScreenState extends State<SmsChatScreen> {
  final Telephony telephony = Telephony.instance;
  List<OverChargeRecordData> overCharges = [];
  int _currentIndex = 0;

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
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: 22,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SavedOverChargesScreen(
                        phone: widget.phone,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.balance,
                  color: AppColors.white,
                  size: 32,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: const BoxDecoration(
                color: AppColors.greyWell,
                border: Border(
                  top: BorderSide(color: AppColors.white1, width: 0.2),
                  bottom: BorderSide(color: AppColors.white1, width: 0.2),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    periodWidget(
                      text: 'Today',
                      index: 0,
                      icon: Icon(
                        Icons.access_time_sharp,
                        color: _currentIndex == 0
                            ? AppColors.white
                            : AppColors.white1,
                        size: 20,
                      ),
                    ),
                    periodWidget(
                      text: 'Week',
                      index: 1,
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: _currentIndex == 1
                            ? AppColors.white
                            : AppColors.white1,
                        size: 18.20,
                      ),
                    ),
                    periodWidget(
                      text: 'Month',
                      index: 2,
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: _currentIndex == 2
                            ? AppColors.white
                            : AppColors.white1,
                        size: 20,
                      ),
                    ),
                    periodWidget(
                      text: 'Year',
                      index: 3,
                      icon: Icon(
                        CupertinoIcons.bolt,
                        color: _currentIndex == 3
                            ? AppColors.white
                            : AppColors.white1,
                        size: 15.20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 25.50),
              child: Column(
                children: [
                  UnlawfulOverchargeCard(
                    amount: getUnLawfulAmount(),
                    flagged: getUnLawfulFlagged(),
                    compliant: 1,
                    scanned: 19,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.green,
                        width: .2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(
                        255,
                        34,
                        94,
                        37,
                      ).withOpacity(.2),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          weight: 1,
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 230,
                          child: Text(
                            "CBN Circular FPR/DIR/CIR/GEN/01/020:\nTransfer fee cap for ₦5k–₦50k bracket = ₦10.00",
                            style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.26,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 450,
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(vertical: 30),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chatIndex = chats.length - 1 - index;

                  final sms = chats[chatIndex];

                  SmsMessage? previousSms;
                  double? overCharge;

                  if (chatIndex > 0) {
                    previousSms = chats[chatIndex - 1];

                    if (previousSms.body != null && sms.body != null) {
                      // CHECK HIVE BEFORE CALCULATING
                      final alreadyAdded = isTransactionAlreadyAddedToHive(
                        previousMessage: previousSms.body!,
                        currentMessage: sms.body!,
                      );

                      if (!alreadyAdded) {
                        overCharge = calculateOverCharge(
                          previousSms: previousSms.body!,
                          currentSms: sms.body!,
                        );
                      }
                    }
                  }

                  return Column(
                    children: [
                      // Transaction message
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              86,
                              51,
                              54,
                              106,
                            ),
                            border: Border.all(
                              color: AppColors.white1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            sms.body ?? '',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      // ONLY show if NOT already in Hive
                      if (overCharge != null && previousSms != null)
                        GestureDetector(
                          onTap: () {
                            _confirmOverCharge(
                              previousMessage: previousSms!.body!,
                              currentMessage: sms.body!,
                              overCharge: overCharge!,
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.shade300.withOpacity(.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Overcharged: ₦'
                                '${overCharge.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isTransactionAlreadyAddedToHive({
    required String previousMessage,
    required String currentMessage,
  }) {
    final box = Hive.box<OverChargeRecordData>('overCharges');

    return box.values.any(
      (record) =>
          record.phone == widget.phone &&
          record.previousMessage.trim() == previousMessage.trim() &&
          record.currentMessage.trim() == currentMessage.trim(),
    );
  }

  Future<void> _confirmOverCharge({
    required String previousMessage,
    required String currentMessage,
    required double overCharge,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Confirm Overcharge',
          ),
          content: Text(
            'Are you sure this is an overcharge?\n\n'
            'Calculated overcharge: ₦${overCharge.toStringAsFixed(2)}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await _saveOverCharge(
      previousMessage: previousMessage,
      currentMessage: currentMessage,
      overCharge: overCharge,
    );
  }

  Future<void> _saveOverCharge({
    required String previousMessage,
    required String currentMessage,
    required double overCharge,
  }) async {
    final box = Hive.box<OverChargeRecordData>('overCharges');

    final record = OverChargeRecordData(
        phone: widget.phone,
        previousMessage: previousMessage,
        currentMessage: currentMessage,
        overCharge: overCharge,
        date: DateTime.now(),
        amount: extractAmount(currentMessage));

    await box.add(record);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Overcharge added successfully',
        ),
      ),
    );
  }

  dynamic getUnLawfulAmount() {
    if (_currentIndex == 1) {
      return getSummary(const Duration(days: 7)).total;
    }
    if (_currentIndex == 2) {
      return monthSummary().total;
    }
    if (_currentIndex == 3) {
      return yearSummary().total;
    }
    return getSummary(const Duration(days: 1)).total;
  }

  dynamic getUnLawfulFlagged() {
    if (_currentIndex == 1) {
      return getSummary(const Duration(days: 7)).count;
    }
    if (_currentIndex == 2) {
      return monthSummary().count;
    }
    if (_currentIndex == 3) {
      return yearSummary().count;
    }
    return getSummary(const Duration(days: 1)).count;
  }

  Widget periodWidget({
    required String text,
    required Icon icon,
    required int index,
  }) =>
      GestureDetector(
        onTap: () {
          _currentIndex = index;
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: _currentIndex == index ? AppColors.purple : AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(32),
            color: _currentIndex == index
                ? AppColors.purple
                : AppColors.transparent,
          ),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: _currentIndex == index
                      ? AppColors.white
                      : AppColors.white1,
                  fontFamily: 'Arial',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );

  double? calculateOverCharge({
    required String previousSms,
    required String currentSms,
  }) {
    final previousBalance = extractBalance(previousSms);
    final currentBalance = extractBalance(currentSms);

    final amount = extractAmount(currentSms);

    final expected = expectedCharge(amount);

    var expectedBalance;

    final isCredit = RegExp(
      r'^(credit|cr)\b',
      caseSensitive: false,
    ).hasMatch(currentSms.trim());

    double difference = 0;
    // if (currentSms
    //         .toString()
    //         .substring(0, 6)
    //         .toLowerCase()
    //         .contains('credit') ||
    //     currentSms.toString().substring(0, 5).toLowerCase().contains('debit') ||
    //     currentSms.toString().substring(0, 1).toLowerCase().contains('cr') ||
    //     currentSms.toString().substring(0, 1).toLowerCase().contains('dr')) {
    //   if (currentSms.toString().substring(0, 6).toLowerCase() == 'credit' ||
    //       currentSms.toString().substring(0, 1).toLowerCase().contains('cr')) {
    //     expectedBalance = previousBalance + amount;
    //     difference = (expectedBalance - currentBalance);
    //   } else {
    //     expectedBalance = previousBalance - amount - expected;
    //     difference = (expectedBalance - currentBalance);
    //   }
    // }
    // if (currentSms
    //         .toString()
    //         .substring(4, 9)
    //         .toLowerCase()
    //         .contains('credit') ||
    //     currentSms.toString().substring(4, 8).toLowerCase().contains('debit') ||
    //     currentSms.toString().substring(4, 5).toLowerCase().contains('cr') ||
    //     currentSms.toString().substring(4, 5).toLowerCase().contains('dr')) {
    //   print('Second IF::: ${currentSms.toString()}');
    //   if (currentSms.toString().substring(4, 9).toLowerCase() == 'credit' ||
    //       currentSms.toString().substring(4, 5).toLowerCase() == 'cr') {
    //     expectedBalance = previousBalance + amount;
    //     difference = (expectedBalance - currentBalance);
    //   } else {
    //     expectedBalance = previousBalance - amount - expected;
    //     difference = (expectedBalance - currentBalance);
    //   }
    // }

    // if (currentSms.toString().substring(0, 2).toLowerCase().contains('cr') ||
    //     currentSms.toString().substring(0, 2).toLowerCase().contains('dr')) {
    //   print(
    //       'third IF::: ${currentSms.toString().substring(0, 2).toLowerCase()},');
    //   if (currentSms.toString().substring(0, 2).toLowerCase() == 'cr') {
    //     expectedBalance = previousBalance + amount;
    //     difference = (expectedBalance - currentBalance);
    //   } else {
    //     expectedBalance = previousBalance - amount - expected;
    //     difference = (expectedBalance - currentBalance);
    //   }
    // }
    if (isCredit) {
      expectedBalance = previousBalance + amount;
      difference = (expectedBalance - currentBalance);
    } else {
      expectedBalance = previousBalance - amount - expected;
      difference = (expectedBalance - currentBalance);
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
    final match = RegExp(
      r'Amt:\s*NGN\s*(-?[\d,]+(?:\.\d{2})?)',
      caseSensitive: false,
    ).firstMatch(body);

    if (match == null) return 0.0;

    final value = match.group(1)!.replaceAll(',', '');

    return double.tryParse(value)?.abs() ?? 0.0;
  }

  double extractBalance(String body) {
    final match = RegExp(r'Bal:\s*NGN([\d,]+\.\d{2})').firstMatch(body) ??
        RegExp(r'BAL:\s*NGN([\d,]+\.\d{2})').firstMatch(body) ??
        RegExp(r'BALANCE:\s*NGN([\d,]+\.\d{2})').firstMatch(body) ??
        RegExp(r'Balance:\s*NGN([\d,]+\.\d{2})').firstMatch(body);
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

  // void calculateAllOverCharges() {
  //   overCharges.clear();

  //   for (int i = 1; i < chats.length; i++) {
  //     final previous = chats[i - 1];
  //     final current = chats[i];

  //     final charge = calculateOverCharge(
  //       previousSms: previous.body!,
  //       currentSms: current.body!,
  //     );

  //     if (charge != null) {
  //       overCharges.add(
  //         OverChargeRecord(
  //           amount: charge,
  //           date: DateTime.fromMillisecondsSinceEpoch(current.date!),
  //         ),
  //       );
  //     }
  //   }
  // }

  void calculateAllOverCharges() {
    overCharges.clear();

    for (int i = 1; i < chats.length; i++) {
      final previous = chats[i - 1];
      final current = chats[i];

      if (previous.body == null || current.body == null) {
        continue;
      }

      // FIRST CHECK HIVE
      final alreadyAdded = isTransactionAlreadyAddedToHive(
        previousMessage: previous.body!,
        currentMessage: current.body!,
      );

      // If this transaction has already been
      // confirmed and added to Hive, completely
      // skip the overcharge calculation.
      if (alreadyAdded) {
        continue;
      }

      // ONLY calculate if it isn't already in Hive.
      final charge = calculateOverCharge(
        previousSms: previous.body!,
        currentSms: current.body!,
      );

      if (charge == null) {
        continue;
      }

      overCharges.add(
        OverChargeRecordData(
          phone: widget.phone,
          previousMessage: previous.body!,
          currentMessage: current.body!,
          overCharge: charge,
          amount: extractAmount(current.body!),
          date: DateTime.fromMillisecondsSinceEpoch(
            current.date!,
          ),
        ),
      );
    }

    if (mounted) {
      setState(() {});
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
