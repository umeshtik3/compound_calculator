import 'form_field_config.dart';

class TimesToCompoundFieldConfig extends FormFieldConfig {
  final String labelText;
  final Map<String, String> values;

  TimesToCompoundFieldConfig({
    required String textColor,
    required double textSize,
    required this.labelText,
    required this.values,
  }) : super(textColor: textColor, textSize: textSize);

  factory TimesToCompoundFieldConfig.fromJson(Map<String, dynamic> json) {
    return TimesToCompoundFieldConfig(
      textColor: json['textColor'],
      textSize: json['textSize'].toDouble(),
      labelText: json['labelText'],
      values: Map<String, String>.from(json['values']),
    );
  }
}
