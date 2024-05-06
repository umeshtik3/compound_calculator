import 'dart:convert';
import 'dart:math';

import 'package:calculator/generic_dropdown_widget.dart';
import 'package:calculator/helper.dart';
import 'package:calculator/input_form_field_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CompoundInterestCalculatorApp());
}

class CompoundInterestCalculatorApp extends StatelessWidget {
  const CompoundInterestCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound Interest Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CompoundInterestCalculatorScreen(),
    );
  }
}

class CompoundInterestCalculatorScreen extends StatefulWidget {
  const CompoundInterestCalculatorScreen({super.key});

  @override
  createState() => _CompoundInterestCalculatorScreenState();
}

class _CompoundInterestCalculatorScreenState
    extends State<CompoundInterestCalculatorScreen> {
  int? rateOfInterest;
  double? principalAmount;
  int? compoundFrequency;
  int? numberOfYears;
  double? totalAmount;
  Map<String, dynamic>? config = {};
  FormFieldModel? modelList;
  final _formKey = GlobalKey<FormState>();
  Field? rateOfInterestModel;
  Field? compoundFrequencyModel;
  Field? numberOfYearsModel;
  Field? prinicpalAmountModel;
  Field? displayOutputField;

  @override
  void initState() {
    super.initState();
    config = jsonDecode(FixtureUtil.json);
    createModelFieldList();
  }

  void createModelFieldList() {
    modelList = FormFieldModel.fromJson(config!);
    rateOfInterestModel = modelList?.fields?.firstWhere(
        (e) => e.type == "dropdown" && e.name == 'rate_of_interest');
    compoundFrequencyModel = modelList?.fields?.firstWhere(
        (e) => e.type == "dropdown" && e.name == 'compound_frequency');
    numberOfYearsModel = modelList?.fields?.firstWhere(
        (e) => e.type == "dropdown" && e.name == 'number_of_years');
    prinicpalAmountModel = modelList?.fields
        ?.firstWhere((e) => e.type == "text" && e.name == 'principal_amount');
    displayOutputField = modelList?.fields
        ?.firstWhere((e) => e.type == "multi" && e.name == 'display');
  }

  int findValueForNumber(int number, Map<String, int> rangeValues) {
    int defaultValue = rangeValues['default'] ?? 0;

    for (var entry in rangeValues.entries) {
      var range = entry.key.split('-');
      if (range.length != 2) {
        // Invalid range format
        continue;
      }

      int start = int.tryParse(range[0])!;
      int end = int.tryParse(range[1])!;

      if (number >= start && number <= end) {
        return entry.value;
      }
    }

    return defaultValue;
  }

  int? calculateCompoundedTimes(int interestRate) {
    if (interestRate > 7) {
      return 1;
    } else if (interestRate >= 4 && interestRate <= 6) {
      return 2;
    } else {
      return 4;
    }
  }

  List<Value> createValueList(
      int? compoundedYears, Map<String, Val> validators) {
    List<Value> values = [];
    if (validators.containsKey(compoundedYears.toString())) {
      int min = validators[compoundedYears.toString()]!.min!;
      int max = validators[compoundedYears.toString()]!.max!;
      for (int i = min; i <= max; i++) {
        values.add(Value(value: i, label: i.toString()));
      }
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: rateOfInterestModel != null &&
                  compoundFrequencyModel != null &&
                  numberOfYearsModel != null &&
                  prinicpalAmountModel != null &&
                  displayOutputField != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      DropdownFormField<Value>(
                        items: rateOfInterestModel!.values,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select rate of interest';
                          }
                          return null;
                        },
                        initialValue: rateOfInterestModel!.values!.first,
                        field: rateOfInterestModel,
                        onChanged: (Value? value) {
                          setState(() {
                            rateOfInterest = value!.value!;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          int? amount;
                          if (rateOfInterest != null &&
                              principalAmount != null &&
                              (value != null && value.isNotEmpty)) {
                            amount = findValueForNumber(rateOfInterest!,
                                prinicpalAmountModel!.minAmount!);
                            if (int.tryParse(value)! < amount) {
                              return '${prinicpalAmountModel!.errorMessage?.min} $amount';
                            }
                            if (int.tryParse(value)! >
                                prinicpalAmountModel!.maxAmount!) {
                              return '${prinicpalAmountModel!.errorMessage?.max} ${prinicpalAmountModel!.maxAmount!}';
                            }
                          }

                          if (value == null || value.isEmpty) {
                            return 'Please enter principal amount';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              principalAmount = double.tryParse(value)!;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: prinicpalAmountModel?.label,
                          hintText: prinicpalAmountModel?.hintText,
                          labelStyle: TextStyle(
                            color: prinicpalAmountModel?.textColor != null
                                ? Color(int.parse(
                                        prinicpalAmountModel!.textColor!
                                            .substring(1, 7),
                                        radix: 16) +
                                    0xFF000000)
                                : Colors.white,
                            fontSize: prinicpalAmountModel?.textSize != null
                                ? prinicpalAmountModel!.textSize?.toDouble()
                                : 16,
                          ),
                        ),
                      ),
                      DropdownFormField<Value>(
                        items: compoundFrequencyModel!.values,
                        initialValue: compoundFrequencyModel!.values!.first,
                        field: compoundFrequencyModel,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select compound frequency';
                          }
                          return null;
                        },
                        onChanged: (Value? value) {
                          setState(() {
                            if (rateOfInterest != null) {
                              compoundFrequency =
                                  calculateCompoundedTimes(rateOfInterest!);
                            }
                          });
                        },
                      ),
                      DropdownFormField<Value>(
                        items: createValueList(
                            compoundFrequency, numberOfYearsModel!.validators!),
                        field: numberOfYearsModel,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select number of years';
                          }
                          return null;
                        },
                        onChanged: (Value? value) {
                          numberOfYears = value?.value;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if ((_formKey.currentState!.validate()) &&
                              rateOfInterest != null &&
                              compoundFrequency != null &&
                              principalAmount != null &&
                              numberOfYears != null) {
                            // Calculate compound interest here

                            final exponent =
                                compoundFrequency! * numberOfYears!;
                            double ratePerPeriod =
                                rateOfInterest! / compoundFrequency!;
                            totalAmount = principalAmount! *
                                pow(1 + ratePerPeriod, exponent);

                            displayOutput(displayOutputField!.modeOfDisplay!,
                                context, totalAmount.toString());
                          }
                        },
                        child: const Text('Calculate'),
                      ),
                      const SizedBox(height: 20),
                    ])
              : const SizedBox(),
        ),
      ),
    );
  }

  Widget displayOutput(String mode, BuildContext ctx, String outputValue) {
    switch (mode) {
      case 'snackbar':
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text(outputValue)),
        );
        return const SizedBox.shrink();
      case 'pop-up-dialog':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Output Value'),
              content: Text(outputValue),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
        return const SizedBox.shrink();
      case 'text-field':
        return TextField(
          readOnly: true,
          controller: TextEditingController(text: outputValue),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
