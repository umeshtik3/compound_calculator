import 'dart:convert';


class FormFieldModel {
  final List<Field>? fields;

  FormFieldModel({
    this.fields,
  });

  factory FormFieldModel.fromRawJson(String str) =>
      FormFieldModel.fromJson(json.decode(str));

  factory FormFieldModel.fromJson(Map<String, dynamic> json) => FormFieldModel(
        fields: json["fields"] == null
            ? []
            : List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
      );
}

class Field {
  final String? name;
  final String? type;
  final String? label;
  final String? textColor;
  final int? textSize;
  final List<Value>? values;
  final String? hintText;
  final Map<String, int>? minAmount;
  final int? maxAmount;
  final ErrorMessage? errorMessage;
  final Map<String, Val>? validators;
  final String? modeOfDisplay;

  Field({
    this.name,
    this.type,
    this.label,
    this.textColor,
    this.textSize,
    this.values,
    this.hintText,
    this.minAmount,
    this.maxAmount,
    this.errorMessage,
    this.validators,
    this.modeOfDisplay,
  });

  factory Field.fromRawJson(String str) => Field.fromJson(json.decode(str));

  factory Field.fromJson(Map<String, dynamic> json) => Field(
      name: json["name"],
      type: json["type"],
      label: json["label"],
      textColor: json["textColor"],
      textSize: json["textSize"],
      values: json["values"] == null
          ? []
          : List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      hintText: json["hintText"],
      minAmount: json["minAmount"] == null
          ? null
          : Map.from(json["minAmount"])
              .map((k, v) => MapEntry<String, int>(k, v)),
      maxAmount: json["maxAmount"],
      errorMessage: json["errorMessage"] == null
          ? null
          : ErrorMessage.fromJson(json["errorMessage"]),
      validators: json["validators"] == null
          ? null
          : Map.from(json["validators"]!)
              .map((k, v) => MapEntry<String, Val>(k, Val.fromJson(v))),
      modeOfDisplay: json["modeOfDisplay"]);
}

class ErrorMessage {
  final String? min;
  final String? max;

  ErrorMessage({
    this.min,
    this.max,
  });

  factory ErrorMessage.fromRawJson(String str) =>
      ErrorMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class Value {
  final int? value;
  final String? label;

  Value({
    this.value,
    this.label,
  });

  factory Value.fromRawJson(String str) => Value.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}

class Val {
  final int? min;
  final int? max;

  Val({
    this.min,
    this.max,
  });

  factory Val.fromRawJson(String str) => Val.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Val.fromJson(Map<String, dynamic> json) => Val(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}



