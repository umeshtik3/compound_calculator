
import 'form_field_config.dart';

enum DisplayMode {
  snackBar,
  popUpDialog,
  textField,
}
class OutputValueConfig extends FormFieldConfig {
  final String labelText;
  final DisplayMode modeOfDisplay;

  OutputValueConfig({
    required String textColor,
    required double textSize,
    required this.labelText,
    required this.modeOfDisplay,
  }) : super(textColor: textColor, textSize: textSize);

  factory OutputValueConfig.fromJson(Map<String, dynamic> json) {
    return OutputValueConfig(
      textColor: json['textColor'],
      textSize: json['textSize'].toDouble(),
      labelText: json['labelText'],
      modeOfDisplay: _parseModeOfDisplay(json['modeOfDisplay']),
    );
  }
  static DisplayMode _parseModeOfDisplay(String mode) {
    switch (mode) {
      case 'snack-bar':
        return DisplayMode.snackBar;
      case 'pop-up-dialog':
        return DisplayMode.popUpDialog;
      case 'text-field':
        return DisplayMode.textField;
      default:
        throw ArgumentError('Invalid mode of display: $mode');
    }
  }
}
