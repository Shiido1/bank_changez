import 'package:bank_chargez/ui/utilities/color.dart';
import 'package:flutter/material.dart';

import 'ui/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme:ColorScheme.fromSeed(seedColor: AppColors.primary)),
      home:  const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
