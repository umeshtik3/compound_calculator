import 'dart:convert';
import 'package:calculator/features/utils/helper.dart';
import 'package:flutter/material.dart';
import 'features/compund_calculator/data/models/app_config.dart';
import 'features/compund_calculator/presentation/page/calculator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound Interest Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CompoundInterestCalculatorApp(
        appConfig: AppConfig.fromJson(jsonDecode(FixtureUtil.json)),
      ),
    );
  }
}
