// ignore_for_file: deprecated_member_use

import 'package:bank_chargez/telephony_package/sms_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telephony/telephony.dart';
import '../utilities/color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 

  final Telephony telephony = Telephony.instance;

  List<SmsMessage> message = [];

  @override
  void initState() {
    loadSms();
    super.initState();
  }

  Future<void> loadSms() async {
    bool? granted = await telephony.requestPhoneAndSmsPermissions;

    if (granted == true) {
      final sms = await telephony.getInboxSms(
        sortOrder: [
          OrderBy(SmsColumn.DATE, sort: Sort.DESC),
        ],
      );

// Banks you want to show
      const banks = [
        "GTBANK",
        "ACCESS",
        "UBA",
        "FIRSTBANK",
        "ZENITH",
        "FIDELITY",
        "FCMB",
        "STERLING",
        "WEMA",
        "UNION",
        "OPAY",
        "PALMPAY",
        "MONIEPOINT",
        "ECOBANK",
        "FIRSTCITY",
        "KEYSTONE",
        "POLARIS",
        "STERLING",
        "STANBIC",
        "WEMA",
        "UNITY",
      ];

// Keep only bank SMS
      final bankSms = sms.where((e) {
        final sender = (e.address ?? "").toUpperCase();

        return banks.any((bank) => sender.contains(bank));
      }).toList();

// Remove duplicate senders
      final Map<String, SmsMessage> uniqueMessages = {};

      for (final sms in bankSms) {
        final sender = sms.address ?? "";
        uniqueMessages.putIfAbsent(sender, () => sms);
      }

      setState(() {
        message = uniqueMessages.values.toList();
      });
    }
  }

  // Future<void> loadSms() async {
  //   bool? granted = await telephony.requestPhoneAndSmsPermissions;

  //   if (granted == true) {
  //     final sms = await telephony
  //         .getInboxSms(sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)]);

  //     setState(() {
  //       message = sms;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.greyWell,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: AppColors.white, size: 24.0),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield_outlined, color: AppColors.purple, size: 24.0),
            SizedBox(width: 6),
            Text(
              'Bank Chargez!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                letterSpacing: -1,
                fontFamily: 'GoogleSan',
                fontSize: 22.4,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.settings_outlined, color: AppColors.white, size: 24.0),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 25.50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.greyWell,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.white1, width: .2),
                    ),
                    child: Column(
                      children: [
                        // const Padding(
                        //   padding: EdgeInsets.fromLTRB(18, 20, 18, 10),
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.warning_amber_rounded,
                        //         color: AppColors.orange,
                        //         size: 22,
                        //       ),
                        //       SizedBox(width: 10),
                        //       Text(
                        //         "Latest Violation",
                        //         style: TextStyle(
                        //           color: AppColors.orange,
                        //           fontWeight: FontWeight.w700,
                        //           letterSpacing: 0,
                        //           fontSize: 16,
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Text(
                        //         "13 Jul 2026",
                        //         style: TextStyle(
                        //           color: AppColors.greyF,
                        //           fontWeight: FontWeight.w400,
                        //           letterSpacing: 0,
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const Divider(
                        //   color: AppColors.white1,
                        //   thickness: 0.2,
                        //   // height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     Container(
                              //       padding: const EdgeInsets.all(12),
                              //       decoration: const BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         color: AppColors.orange,
                              //       ),
                              //       child: const Text(
                              //         "GT",
                              //         style: TextStyle(
                              //           color: AppColors.white,
                              //           fontWeight: FontWeight.w600,
                              //           letterSpacing: -1,
                              //           fontSize: 20,
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(width: 12),
                              //     const Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           "GTBank",
                              //           style: TextStyle(
                              //             color: AppColors.white,
                              //             fontWeight: FontWeight.w600,
                              //             letterSpacing: -1,
                              //             fontSize: 22,
                              //           ),
                              //         ),
                              //         Text(
                              //           "Inter-bank Transfer · 09:14 AM",
                              //           style: TextStyle(
                              //             color: AppColors.greyF,
                              //             fontWeight: FontWeight.w400,
                              //             letterSpacing: -1,
                              //             fontSize: 16,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 22),
                              // const Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Imposed Charge",
                              //       style: TextStyle(
                              //         color: AppColors.greyF,
                              //         fontWeight: FontWeight.w400,
                              //         letterSpacing: -1,
                              //         fontSize: 18,
                              //       ),
                              //     ),
                              //     Text(
                              //       "₦52.50",
                              //       style: TextStyle(
                              //         color: AppColors.red,
                              //         fontWeight: FontWeight.w800,
                              //         fontSize: 20,
                              //         letterSpacing: -2,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const Divider(
                              //   color: AppColors.white1,
                              //   thickness: 0.2,
                              //   // height: 10,
                              // ),
                              // const SizedBox(height: 10),
                              // const Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "CBN Legal Limit",
                              //       style: TextStyle(
                              //         color: AppColors.greyF,
                              //         fontWeight: FontWeight.w400,
                              //         letterSpacing: -1,
                              //         fontSize: 18,
                              //       ),
                              //     ),
                              //     Text(
                              //       "₦10.00",
                              //       style: TextStyle(
                              //         color: AppColors.green,
                              //         fontWeight: FontWeight.w800,
                              //         fontSize: 20,
                              //         letterSpacing: -2,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const Divider(
                              //   color: AppColors.white1,
                              //   thickness: 0.2,
                              //   // height: 10,
                              // ),
                              // const SizedBox(height: 10),
                              // const Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "You Were Overcharged",
                              //       style: TextStyle(
                              //         color: AppColors.white,
                              //         fontWeight: FontWeight.w500,
                              //         letterSpacing: -2,
                              //         fontSize: 18.0,
                              //       ),
                              //     ),
                              //     Text(
                              //       "₦42.50",
                              //       style: TextStyle(
                              //         color: AppColors.orange,
                              //         fontWeight: FontWeight.w800,
                              //         fontSize: 21.0,
                              //         letterSpacing: -2,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 30),
                              // const ButtonWidget(
                              //   icon: Icon(
                              //     CupertinoIcons.bolt,
                              //     color: AppColors.white,
                              //     weight: 20,
                              //     size: 20,
                              //   ),
                              //   buttonText: 'ONE-TAP DISPUTE (₦100)',
                              //   fontSize: 20.8,
                              //   color: AppColors.white,
                              //   buttonColor: AppColors.purple,
                              //   buttonBorderColor: Color.fromARGB(
                              //     255,
                              //     139,
                              //     67,
                              //     241,
                              //   ),
                              // ),
                              // const SizedBox(height: 20),
                              // const SizedBox(height: 20),
                              Text(
                                "All Recent Alerts".toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.greyF,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 20),

                              SizedBox(
                                height: message.length>4? 500:350,
                                child: ListView.builder(
                                    itemCount: message.length,
                                    itemBuilder: (context, index) {
                                      final sms = message[index];
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SmsChatScreen(
                                                    phone: sms.address ?? ''))),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(17.22),
                                          decoration: BoxDecoration(
                                            color: AppColors.greyWell,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: AppColors.white1,
                                              width: .2,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.orange,
                                                ),
                                                child: Text(
                                                  "${sms.address}"
                                                      .toUpperCase()
                                                      .substring(0, 2),
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: -1,
                                                    fontSize: 18.20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${sms.address}",
                                                    style: const TextStyle(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -1,
                                                      fontSize: 19.20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      sms.body ?? '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: AppColors.greyF,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -1,
                                                        fontSize: 15.4,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .warning_amber_rounded,
                                                        color: AppColors.red,
                                                        size: 14.2,
                                                      ),
                                                      SizedBox(width: 5.2),
                                                      Text(
                                                        "₦52.50",
                                                        style: TextStyle(
                                                          color: AppColors.red,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0,
                                                          letterSpacing: -2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    DateFormat('dd MMM, yyyy')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                sms.date ?? 0)),
                                                    style: const TextStyle(
                                                      color: AppColors.greyF,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: -1,
                                                      fontSize: 13.4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              //////
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(17.22),
                                decoration: BoxDecoration(
                                  color: AppColors.greyWell,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.white1,
                                    width: .2,
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.verified_outlined,
                                      color: AppColors.green,
                                      size: 30,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Your Accounts are Safe",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -1,
                                        fontSize: 19.20,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Keep the app active in the background. We'll alert you the moment a bank breaks a CBN fee rule.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          132,
                                          153,
                                          175,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0,
                                        fontSize: 14.20,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }}
