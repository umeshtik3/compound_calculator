class FormFieldConfig {
  final String textColor;
  final double textSize;

  FormFieldConfig({required this.textColor, required this.textSize});

  factory FormFieldConfig.fromJson(Map<String, dynamic> json) {
    return FormFieldConfig(
      textColor: json['textColor'],
      textSize: json['textSize'].toDouble(),
    );
  }
}
