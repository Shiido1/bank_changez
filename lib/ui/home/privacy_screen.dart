// ignore_for_file: deprecated_member_use

import 'package:bank_chargez/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import '../utilities/color.dart';


class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.22, vertical: 25.50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.purple.withOpacity(.10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.purple.withOpacity(.18),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 34, 44, 55),
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: Color(0xFF6A00FF),
                          size: 70,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 26,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Privacy is Our Shield',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                letterSpacing: -1,
                fontFamily: 'Arial',
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 10.20),
            const Text(
              'Bank Chargez! works 100% offline to audit bank fees. We prioritize your account security over everything else.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 155, 180, 206),
                letterSpacing: -1,
                fontFamily: 'Arial',
                fontSize: 18.6,
              ),
            ),
            const SizedBox(height: 20),
            privacyWidgetContainer(
              icon: const Icon(Icons.lock_outline, color: AppColors.purple, size: 22),
              iconColor: AppColors.purple,
              text: '🔒 No BVN or Passwords',
              texts:
                  'We never ask for, collect, or store\nyour sensitive banking credentials.',
            ),
            privacyWidgetContainer(
              icon: const Icon(Icons.phone_android, color: AppColors.green, size: 22),
              iconColor: AppColors.green,
              text: '📱 On-Device Audit Only',
              texts:
                  'All text message scanning and financial math happen completely inside this phone.',
            ),
            privacyWidgetContainer(
              icon: const Icon(Icons.wifi_off_sharp, color: AppColors.red, size: 22),
              iconColor: AppColors.red,
              text: '📡 Zero Cloud Servers',
              texts:
                  'Published and secured locally in Nigeria by Geosoft Solutions Limited',
            ),
            privacyWidgetContainer(
              icon: const Icon(
                Icons.verified_outlined,
                color: AppColors.greyF,
                size: 22,
              ),
              iconColor: AppColors.greyF,
              text: '📋 Google Play Compliant',
              texts:
                  'Registered under the SMS-based financial tracking exception. You may revoke access anytime in Android Settings.',
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16.20),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 64, 80, 97),
                  width: .78,
                ),
                color: const Color.fromARGB(255, 34, 44, 55),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Geosoft Solutions Limited · Plot 746, ACO Estate, Airport Road, Abuja, FCT bankchargez@geosoftsolutionslimited.com.ng',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 155, 180, 206),
                  letterSpacing: -1,
                  fontFamily: 'Arial',
                  fontSize: 14.80,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ButtonWidget(
              icon: Icon(
                Icons.shield_outlined,
                color: AppColors.white,
                size: 20,
              ),
              buttonText: 'AGREE & ACTIVATE SHIELD',
              fontSize: 17.8,
              color: AppColors.white,
              buttonColor: AppColors.purple,
              buttonBorderColor: Color.fromARGB(255, 139, 67, 241),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Tapping grants SMS read permission to detect hidden fees',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 155, 180, 206),
                letterSpacing: -1,
                fontFamily: 'GoogleSan',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget privacyWidgetContainer({
    Icon? icon,
    Color? iconColor,
    String? text,
    String? texts,
  }) => Container(
    margin: const EdgeInsets.only(bottom: 16.20),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 64, 80, 97), width: .78),
      color: AppColors.greyWell,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.2),
            color: iconColor!.withOpacity(.12),
          ),
          child: icon,
        ),
        const SizedBox(width: 12.20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                letterSpacing: -1,
                fontFamily: 'Arial',
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5.20),
            SizedBox(
              width: 220,
              child: Text(
                texts ?? '',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 155, 180, 206),
                  letterSpacing: -1,
                  fontFamily: 'Arial',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
