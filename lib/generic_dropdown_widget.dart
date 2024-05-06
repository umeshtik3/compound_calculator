import 'package:calculator/input_form_field_model.dart';
import 'package:flutter/material.dart';

class DropdownFormField<T> extends StatelessWidget {
  final List<T>? items;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final Field? field;
  final String? Function(T?)? validator;
  final bool isMultiType;

  const DropdownFormField({
    super.key,
    this.items,
    this.initialValue,
    this.onChanged,
    this.field,
    this.validator,
    this.isMultiType = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: initialValue,
      decoration: InputDecoration(
        labelText: field?.label,
        labelStyle: TextStyle(
          color: field?.textColor != null
              ? Color(int.parse(field!.textColor!.substring(1, 7), radix: 16) +
                  0xFF000000)
              : Colors.white,
          fontSize: field?.textSize != null ? field!.textSize!.toDouble() : 16,
        ),
      ),
      validator: validator,
      items: items?.map((item) {
        if (isMultiType) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }
        final i = item as Value;
        return DropdownMenuItem<T>(
          value: item,
          child: Text(i.label.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
