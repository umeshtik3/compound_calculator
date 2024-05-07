import 'package:flutter/material.dart';

import '../../../utils/custom_theme.dart';
import '../../data/models/principle_amount_field_config.dart';

class PrincipalAmountFormField extends StatelessWidget {
  final PrincipalAmountFieldConfig config;
  final TextEditingController controller;
  final int? selectedRateOfInterest;

  const PrincipalAmountFormField({
    super.key,
    required this.config,
    required this.controller,
    this.selectedRateOfInterest,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: config.hintText,
        hintStyle: TextStyle(
          color: HexColor(config.textColor),
          fontSize: config.textSize,
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        final amount = int.tryParse(value);
        if (amount == null) {
          return 'Please enter a valid number';
        }
        final minAmount =
            config.minAmount[selectedRateOfInterest.toString()] ?? 0;
        if (amount < minAmount || amount > config.maxAmount) {
          return config.errorMessage
              .replaceAll('{minAmount}', '$minAmount')
              .replaceAll('{maxAmount}', '${config.maxAmount}');
        }
        return null;
      },
    );
  }
}
