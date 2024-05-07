
import 'form_field_config.dart';

class NumberOfYearsFieldConfig extends FormFieldConfig {
  final String labelText;
  final Map<String, String> values;

  NumberOfYearsFieldConfig({
    required String textColor,
    required double textSize,
    required this.labelText,
    required this.values,
  }) : super(textColor: textColor, textSize: textSize);

  factory NumberOfYearsFieldConfig.fromJson(Map<String, dynamic> json) {
    return NumberOfYearsFieldConfig(
      textColor: json['textColor'],
      textSize: json['textSize'].toDouble(),
      labelText: json['labelText'],
      values: Map<String, String>.from(json['values']),
    );
  }
}
