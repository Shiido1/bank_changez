// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../utilities/color.dart';
import '../widgets/app_info_card.dart';
import '../widgets/contact_info_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 26, 34),
      appBar: AppBar(
        backgroundColor: AppColors.greyWell,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: AppColors.white, size: 24.0),
        ),
        title: const Text(
          'About the Developer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            letterSpacing: -1,
            fontFamily: 'GoogleSan',
            fontSize: 22.4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.22, vertical: 48),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17.22),
              decoration: BoxDecoration(
                color: AppColors.greyWell,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.white1, width: .2),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.purple, width: .8),
                      borderRadius: BorderRadius.circular(10.2),
                      color: AppColors.purple.withOpacity(.12),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF6A00FF),
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Geosoft Solutions Limited",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.2,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5.10),
                  const Text(
                    "RC: 0000000 · CAC Registered, Nigeria",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 132, 153, 175),
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.1,
                      fontSize: 16.20,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 4.2),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.green, width: .2),
                      borderRadius: BorderRadius.circular(22),
                      color: const Color.fromARGB(
                        255,
                        34,
                        94,
                        37,
                      ).withOpacity(.2),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          color: AppColors.green,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Verified Nigerian Publisher",
                          style: TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.26,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const ContactInfoCard(),
            const SizedBox(height: 20),
            const AppInfoCard(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.greyWell,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(.08)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.open_in_new, color: Colors.deepPurple, size: 18),
                  SizedBox(width: 10.6),
                  Text(
                    "View Official Privacy Policy Document",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: -1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Bank Chargez! is not affiliated with any Nigerian bank or the CBN. All dispute generation is for consumer advocacy purposes only.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyF,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
