// ignore_for_file: deprecated_member_use

import 'package:bank_chargez/ui/utilities/color.dart';
import 'package:flutter/material.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

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
          ContactTile(
            icon: Icons.location_on_outlined,
            iconColor: Color(0xff7B1FFF),
            title: "ADDRESS",
            value: "Plot 746, ACO Estate, Airport Road, Abuja,FCT, Nigeria",
          ),
          Divider(height: 1, color: Color(0xff36414C)),
          ContactTile(
            icon: Icons.phone_outlined,
            iconColor: Colors.green,
            title: "HELPLINES",
            value: "+234 707 923 1415\n+234 814 417 7491",
          ),
          Divider(height: 1, color: Color(0xff36414C)),
          ContactTile(
            icon: Icons.mail_outline,
            iconColor: Colors.deepOrange,
            title: "EMAIL",
            value: "bankchargez@geosoftsolutionslimited.com.ng",
          ),
          Divider(height: 1, color: Color(0xff36414C)),
          ContactTile(
            icon: Icons.language,
            iconColor: Color(0xff8EA2B6),
            title: "WEBSITE",
            value: "geosoftsolutionslimited.com.ng",
          ),
        ],
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String value;
  final double? valueFontSize;
  final double? titleFontSize;

  const ContactTile({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    required this.value,
    this.valueFontSize=16,
    this.titleFontSize=14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.20, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         icon != null? Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xff2A3441),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24.0),
          ):SizedBox.shrink(),
          SizedBox(width: icon != null? 12:0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xff8EA2B6),
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6.10),
                Text(
                  value,
                  style:  TextStyle(
                    color: AppColors.white,
                    fontSize: valueFontSize,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    letterSpacing: -0.1,
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
