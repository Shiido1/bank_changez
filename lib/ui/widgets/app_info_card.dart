// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../utilities/color.dart';

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyWell,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Column(
        children: const [
          AppTile(title: "App Version", value: "1.0.0 (Build 1)"),
          Divider(height: 1, color: Color(0xff36414C)),
          AppTile(title: "Platform", value: "Android 8.0+"),
          Divider(height: 1, color: Color(0xff36414C)),
          AppTile(title: "CBN Reference", value: "FPR/DIR/CIR/GEN/01/020"),
          Divider(height: 1, color: Color(0xff36414C)),
          AppTile(title: "Data Storage", value: "Local SQLite (Encrypted)"),
        ],
      ),
    );
  }
}

class AppTile extends StatelessWidget {
  final String title;
  final String value;

  const AppTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xff8EA2B6),
              fontSize: 15.68,
              fontWeight: FontWeight.w600,
              letterSpacing: -.19,
            ),
          ),
          SizedBox(
            width: 128.0,
            child: Text(
              value,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 17.80,
                fontWeight: FontWeight.w500,
                height: 1,
                letterSpacing: -0.12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
