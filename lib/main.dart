import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:calculator/generic_dropdown_widget.dart';
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

  dynamic fixture(String file) => jsonDecode(
        File(file).readAsStringSync(),
      );

  @override
  void initState() {
    super.initState();

    const json = ''' {
  "fields": [
    {
      "name": "rate_of_interest",
      "type": "dropdown",
      "label": "Rate of Interest (%)",
      "textColor": "#000000",
      "textSize": 16,
      "values": [
        {"value": 1, "label": "1%"},
        {"value": 2, "label": "2%"},
        {"value": 3, "label": "3%"},
        {"value": 4, "label": "4%"},
        {"value": 5, "label": "5%"},
        {"value": 6, "label": "6%"},
        {"value": 7, "label": "7%"},
        {"value": 8, "label": "8%"},
        {"value": 9, "label": "9%"},
        {"value": 10, "label": "10%"},
        {"value": 11, "label": "11%"},
        {"value": 12, "label": "12%"},
        {"value": 13, "label": "13%"},
        {"value": 14, "label": "14%"},
        {"value": 15, "label": "15%"}
      ]
    },
    {
      "name": "principal_amount",
      "type": "text",
      "label": "Principal Amount",
      "hintText": "Enter principal amount",
      "textColor": "#000000",
      "textSize": 16,
      "minAmount": {
        "1-3": 10000,
        "4-7": 50000,
        "8-12": 75000,
        "default": 100000
      },
      "maxAmount": 10000000,
      "errorMessage": {
        "min": "Minimum amount should be",
        "max": "Maximum amount should be"
      }
    },
    {
      "name": "compound_frequency",
      "type": "dropdown",
      "label": "No. of times compounded per year",
      "textColor": "#000000",
      "textSize": 16,
      "values": [ {"value": 12, "label": "1"},{"value": 6, "label": "2"},{"value": 3, "label": "4"}]
    },
    {
      "name": "number_of_years",
      "type": "dropdown",
      "label": "No. of Years",
      "textColor": "#000000",
      "textSize": 16,
      "validators": {
        "1": {"min": 1, "max": 10},
        "2": {"min": 1, "max": 20},
        "4": {"min": 1, "max": 30}
      }
     
    },
    {
      "name": "display",
      "type":"multi",
      "textColor": "#000000",
      "textSize": 16,
      "label": "Output Widget",
      "modeOfDisplay": "text-field"
    }
  ]
}''';

    config = jsonDecode(json);
    modelList = FormFieldModel.fromJson(config!);
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
    final rateOfInterestModel = modelList?.fields?.firstWhere(
        (e) => e.type == "dropdown" && e.name == 'rate_of_interest');
    final compoundFrequencyModel = modelList?.fields?.firstWhere(
        (e) => e.type == "dropdown" && e.name == 'compound_frequency');
    final numberOfYearsModel = modelList?.fields?.firstWhere(
        (e) => e.type == "dropdown" && e.name == 'number_of_years');
    final prinicpalAmountModel = modelList?.fields
        ?.firstWhere((e) => e.type == "text" && e.name == 'principal_amount');

    final displayOutputField = modelList?.fields
        ?.firstWhere((e) => e.type == "multi" && e.name == 'display');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            DropdownFormField<Value>(
              items: rateOfInterestModel!.values,
              validator: (value) {
                if (value == null) {
                  return 'Please select rate of interest';
                }
                return null;
              },
              initialValue: rateOfInterestModel.values!.first,
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
                  amount = findValueForNumber(
                      rateOfInterest!, prinicpalAmountModel!.minAmount!);
                  if (int.tryParse(value!)! < amount) {
                    return '${prinicpalAmountModel.errorMessage?.min} $amount';
                  }
                  if (int.tryParse(value)! > prinicpalAmountModel.maxAmount!) {
                    return '${prinicpalAmountModel.errorMessage?.max} ${prinicpalAmountModel.maxAmount!}';
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
                              prinicpalAmountModel!.textColor!.substring(1, 7),
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
              initialValue: compoundFrequencyModel.values!.first,
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

                  final exponent = compoundFrequency! * numberOfYears!;
                  double ratePerPeriod = rateOfInterest! / compoundFrequency!;
                  totalAmount =
                      principalAmount! * pow(1 + ratePerPeriod, exponent);

                  displayOutput(displayOutputField!.modeOfDisplay!, context,
                      totalAmount.toString());
                }
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
          ]),
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
