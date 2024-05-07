import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/custom_theme.dart';
import '../../data/models/app_config.dart';
import '../../data/models/output_value_config.dart';
import '../widgets/number_of_years_field.dart';
import '../widgets/output_value_widget.dart';
import '../widgets/principal_amount_field_widget.dart';
import '../widgets/rate_of_interest_field_widget.dart';
import '../widgets/times_to_compound_field.dart';

class CompoundInterestCalculatorApp extends StatefulWidget {
  final AppConfig appConfig;

  const CompoundInterestCalculatorApp({super.key, required this.appConfig});

  @override
  createState() => _CompoundInterestCalculatorAppState();
}

class _CompoundInterestCalculatorAppState
    extends State<CompoundInterestCalculatorApp> {
  late TextEditingController _principalAmountController;
  String _selectedRateOfInterest = '1';
  String _selectedTimesToCompound = '1';
  String _selectedNumberOfYears = '1';
  String _outputValue = '';

  @override
  void initState() {
    super.initState();
    _principalAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _principalAmountController.dispose();
    super.dispose();
  }

  void _calculateCompoundInterest() {
    final double principalAmount =
        double.tryParse(_principalAmountController.text) ?? 0;
    final double rateOfInterest = double.tryParse(widget.appConfig
            .rateOfInterestFieldConfig.values[_selectedRateOfInterest]!
            .replaceAll('%', '')) ??
        0 / 100;
    final int timesToCompound = int.tryParse(_selectedTimesToCompound) ?? 1;
    final int numberOfYears = int.tryParse(_selectedNumberOfYears) ?? 1;

    final double amount = principalAmount *
        pow(1 + rateOfInterest / timesToCompound,
            timesToCompound * numberOfYears);

    setState(() {
      _outputValue = amount.toStringAsFixed(2);
    });

    displayWidget(amount);
  }

  void displayWidget(double amount) {
    if (widget.appConfig.outputValueConfig.modeOfDisplay ==
        DisplayMode.snackBar) {
      showSnackBar(amount);
    } else if (widget.appConfig.outputValueConfig.modeOfDisplay ==
        DisplayMode.popUpDialog) {
      showPopUp(amount);
    }
  }

  void showPopUp(double amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.appConfig.outputValueConfig.labelText),
          content: Text(
            amount.toStringAsFixed(2),
            style: TextStyle(
              color: HexColor(widget.appConfig.outputValueConfig.textColor),
              fontSize: widget.appConfig.outputValueConfig.textSize,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(double amount) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.appConfig.outputValueConfig.labelText}: ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: HexColor(widget.appConfig.outputValueConfig.textColor),
            fontSize: widget.appConfig.outputValueConfig.textSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RateOfInterestFormField(
              config: widget.appConfig.rateOfInterestFieldConfig,
              onChanged: (value) {
                setState(() {
                  _selectedRateOfInterest = value!; // Update here
                  _calculateCompoundInterest();
                });
              },
            ),
            const SizedBox(height: 16.0),
            PrincipalAmountFormField(
              config: widget.appConfig.principalAmountFieldConfig,
              controller: _principalAmountController,
              selectedRateOfInterest: int.tryParse(_selectedRateOfInterest),
            ),
            const SizedBox(height: 16.0),
            TimesToCompoundFormField(
              config: widget.appConfig.timesToCompoundFieldConfig,
              selectedRateOfInterest: _selectedRateOfInterest,
              onChanged: (value) {
                setState(() {
                  _selectedTimesToCompound = value!;
                  _calculateCompoundInterest();
                });
              },
            ),
            const SizedBox(height: 16.0),
            NumberOfYearsFormField(
              config: widget.appConfig.numberOfYearsFieldConfig,
              selectedTimesToCompound: _selectedTimesToCompound,
              onChanged: (value) {
                setState(() {
                  _selectedNumberOfYears = value!;
                  _calculateCompoundInterest();
                });
              },
            ),
            const SizedBox(height: 16.0),
            OutputValueWidget(
              config: widget.appConfig.outputValueConfig,
              value: _outputValue,
            ),
          ],
        ),
      ),
    );
  }
}
