import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../over_charge_record_data.dart';
import '../ui/utilities/color.dart';
import '../ui/widgets/unlawful_over_charged_card.dart';
import 'over_charged_calculator_hive.dart';

class SavedOverChargesScreen extends StatefulWidget {
  final String phone;

  const SavedOverChargesScreen({
    super.key,
    required this.phone,
  });

  @override
  State<SavedOverChargesScreen> createState() => _SavedOverChargesScreenState();
}

class _SavedOverChargesScreenState extends State<SavedOverChargesScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<OverChargeRecordData>(
      'overCharges',
    );

    final records = box.values
        .where(
          (record) => record.phone == widget.phone,
        )
        .toList();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.greyWell,
        title: const Text(
          'Saved Overcharges',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
      ),
      body: records.isEmpty
          ? const Center(
              child: Text(
                'No overcharges added',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            )
          : SingleChildScrollView(
            padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 25.50),
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
                  UnlawfulOverchargeCard(
                    amount: getUnLawfulAmount(),
                    flagged: getUnLawfulFlagged(),
                    compliant: 1,
                    scanned: 19,
                  ),
                  const SizedBox(height: 12),
                   SizedBox(
              height: 450,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final record = records[index];
                    
                        return _overChargeCard(record);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
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

  

  dynamic getUnLawfulAmount() {
    if (_currentIndex == 1) {
      return OverchargeCalculator.week(widget.phone).total;
    }
    if (_currentIndex == 2) {
      return OverchargeCalculator.month(widget.phone).total;
    }
    if (_currentIndex == 3) {
      return OverchargeCalculator.year(widget.phone).total;
    }
    return OverchargeCalculator.today(widget.phone).total;
  }

  dynamic getUnLawfulFlagged() {
    if (_currentIndex == 1) {
      return OverchargeCalculator.week(widget.phone).count;
    }
    if (_currentIndex == 2) {
      return OverchargeCalculator.month(widget.phone).count;
    }
    if (_currentIndex == 3) {
      return OverchargeCalculator.year(widget.phone).count;
    }
    return OverchargeCalculator.today(widget.phone).count;
  }

  Widget _overChargeCard(
    OverChargeRecordData record,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyWell,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.white1,
          width: .3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overcharge',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '₦${record.overCharge.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Previous Transaction',
            style: TextStyle(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            record.previousMessage,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Current Transaction',
            style: TextStyle(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            record.currentMessage,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
