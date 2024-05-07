
import 'form_field_config.dart';

class PrincipalAmountFieldConfig extends FormFieldConfig {
  final String hintText;
  final Map<String, dynamic> minAmount;
  final int maxAmount;
  final String errorMessage;

  PrincipalAmountFieldConfig({
    required String textColor,
    required double textSize,
    required this.hintText,
    required this.minAmount,
    required this.maxAmount,
    required this.errorMessage,
  }) : super(textColor: textColor, textSize: textSize);

  factory PrincipalAmountFieldConfig.fromJson(Map<String, dynamic> json) {
    return PrincipalAmountFieldConfig(
      textColor: json['textColor'],
      textSize: json['textSize'].toDouble(),
      hintText: json['hintText'],
      minAmount: Map<String, dynamic>.from(json['minAmount']),
      maxAmount: json['maxAmount'],
      errorMessage: json['errorMessage'],
    );
  }
}
