import 'package:flutter/material.dart';
import '../../../utils/custom_theme.dart';
import '../../data/models/rate_of_interest_config.dart';

class RateOfInterestFormField extends StatelessWidget {
  final RateOfInterestFieldConfig config;
  final ValueChanged<String?>? onChanged;

  const RateOfInterestFormField(
      {super.key, required this.config, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: config.labelText,
        labelStyle: TextStyle(
          color: HexColor(config.textColor),
          fontSize: config.textSize,
        ),
      ),
      items: config.values.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(
            entry.value,
            style: TextStyle(
              color: HexColor(config.textColor),
              fontSize: config.textSize,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
