// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities/color.dart';

final formatter = NumberFormat('#,##0.00', 'en_US');

class UnlawfulOverchargeCard extends StatelessWidget {
  final double amount;
  final int flagged;
  final int compliant;
  final int scanned;

  const UnlawfulOverchargeCard({
    super.key,
    required this.amount,
    required this.flagged,
    required this.compliant,
    required this.scanned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.red.withOpacity(.1),
            const Color(0xff1D1E2B),
            const Color(0xff1D1E2B),
            const Color(0xff1D1E2B),
            const Color(0xff1D1E2B),
            const Color(0xff172632),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xff7F2A34), width: 1.2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                const Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xffF44336),
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "UNLAWFUL  OVERCHARGES  DETECTED",
                      style: TextStyle(
                        color: Color(0xffF44336),
                        fontWeight: FontWeight.w700,
                        letterSpacing: -2,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Amount
                Text(
                  "₦${formatter.format(amount)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Total Unlawful Overcharges Detected • 18 transactions",
                  style: TextStyle(
                    color: Color(0xff94A8C4),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Colors.white.withOpacity(.12), height: 1),

          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    value: flagged.toString(),
                    title: "FLAGGED",
                    valueColor: const Color(0xffF44336),
                  ),
                ),
                VerticalDivider(color: Colors.white.withOpacity(.12), width: 1),
                Expanded(
                  child: _StatItem(
                    value: compliant.toString(),
                    title: "COMPLIANT",
                    valueColor: const Color(0xff2E9D45),
                  ),
                ),
                VerticalDivider(color: Colors.white.withOpacity(.12), width: 1),
                Expanded(
                  child: _StatItem(
                    value: scanned.toString(),
                    title: "SCANNED",
                    valueColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String title;
  final Color valueColor;

  const _StatItem({
    required this.value,
    required this.title,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.2),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff91A6BF),
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
