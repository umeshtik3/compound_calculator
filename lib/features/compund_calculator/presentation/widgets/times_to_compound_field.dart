import 'package:flutter/material.dart';

import '../../../utils/custom_theme.dart';
import '../../data/models/time_to_compound_field_config.dart';

class TimesToCompoundFormField extends StatelessWidget {
  final TimesToCompoundFieldConfig config;
  final ValueChanged<String?>? onChanged;
  final String selectedRateOfInterest;

  const TimesToCompoundFormField({
    super.key,
    required this.config,
    required this.onChanged,
    required this.selectedRateOfInterest,
  });

  @override
  Widget build(BuildContext context) {
    List<String> dropdownValues = [];

    if (selectedRateOfInterest == '12') {
      dropdownValues.add('1');
    } else if (selectedRateOfInterest == '6') {
      dropdownValues.add('2');
    } else if (selectedRateOfInterest == '3') {
      dropdownValues.add('4');
    } else {
      dropdownValues.addAll(['1', '2', '4']);
    }
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: config.labelText,
        labelStyle: TextStyle(
          color: HexColor(config.textColor),
          fontSize: config.textSize,
        ),
      ),
      value: dropdownValues.first,
      items: dropdownValues.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
