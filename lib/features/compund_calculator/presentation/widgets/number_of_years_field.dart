import 'package:flutter/material.dart';

import '../../../utils/custom_theme.dart';
import '../../data/models/number_of_years_field_config.dart';

class NumberOfYearsFormField extends StatelessWidget {
  final NumberOfYearsFieldConfig config;
  final ValueChanged<String?>? onChanged;
  final String selectedTimesToCompound;

  const NumberOfYearsFormField({
    super.key,
    required this.config,
    required this.onChanged,
    required this.selectedTimesToCompound,
  });

  @override
  Widget build(BuildContext context) {
    List<String> dropdownValues = [];

  
    if (selectedTimesToCompound == '1') {
      dropdownValues
          .addAll(List.generate(10, (index) => (index + 1).toString()));
    } else if (selectedTimesToCompound == '2') {
      dropdownValues
          .addAll(List.generate(20, (index) => (index + 1).toString()));
    } else if (selectedTimesToCompound == '4') {
      dropdownValues
          .addAll(List.generate(30, (index) => (index + 1).toString()));
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
