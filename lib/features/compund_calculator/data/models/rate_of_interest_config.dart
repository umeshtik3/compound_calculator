
import 'form_field_config.dart';

class RateOfInterestFieldConfig extends FormFieldConfig {
  final String labelText;
  final Map<String, String> values;

  RateOfInterestFieldConfig({
    required String textColor,
    required double textSize,
    required this.labelText,
    required this.values,
  }) : super(textColor: textColor, textSize: textSize);

  factory RateOfInterestFieldConfig.fromJson(Map<String, dynamic> json) {
    return RateOfInterestFieldConfig(
      textColor: json['textColor'],
      textSize: json['textSize'].toDouble(),
      labelText: json['labelText'],
      values: Map<String, String>.from(json['values']),
    );
  }
}
