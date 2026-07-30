// ignore_for_file: deprecated_member_use

import 'package:bank_chargez/ui/home/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../utilities/color.dart';
import 'about_screen.dart';
import 'privacy_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> get _body =>const [PrivacyScreen(),  DashboardScreen(), AboutScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: _body[_currentIndex]),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.primary,
            splashColor: AppColors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: AppColors.primary,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primary.withOpacity(.5),
            elevation: 3,
            selectedFontSize: 14.8,
            unselectedFontSize: 14.6,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              fontFamily: 'Arial',
              fontSize: 14.4,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              fontFamily: 'Arial',
              fontSize: 14.4,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == 0
                          ? AppColors.purple
                          : AppColors.grey,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    color: _currentIndex == 0
                        ? AppColors.purple
                        : AppColors.transparent,
                  ),
                  child: const Text(
                    'PRIVACY',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.white1,
                      fontFamily: 'Arial',
                      fontSize: 14,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == 1
                          ? AppColors.purple
                          : AppColors.grey,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    color: _currentIndex == 1
                        ? AppColors.purple
                        : AppColors.transparent,
                  ),
                  child: const Text(
                    'DASHBOARD',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.white1,
                      fontFamily: 'Arial',
                      fontSize: 14,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == 2
                          ? AppColors.purple
                          : AppColors.grey,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    color: _currentIndex == 2
                        ? AppColors.purple
                        : AppColors.transparent,
                  ),
                  child: const Text(
                    'ABOUT',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.white1,
                      fontFamily: 'Arial',
                      fontSize: 14,
                    ),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
