import 'package:flutter/material.dart';

import '../../../utils/custom_theme.dart';
import '../../data/models/output_value_config.dart';

class OutputValueWidget extends StatelessWidget {
  final OutputValueConfig config;
  final String value;

  const OutputValueWidget(
      {super.key, required this.config, required this.value});

      const OutputValueWidget.snackbar({super.key, required this.config, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: HexColor(config.textColor),
        fontSize: config.textSize,
      ),
    );
  }
}
