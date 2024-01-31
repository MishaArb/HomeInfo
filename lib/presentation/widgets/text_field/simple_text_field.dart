import 'package:flutter/material.dart';

buildSimpleTextForm({
  required BuildContext context,
  required String hintText,
  required Function(String) onChanged,
  required TextEditingController controller,
  TextInputType typeKeyboard = TextInputType.number
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      keyboardType: typeKeyboard,
      textCapitalization: TextCapitalization.words,
      maxLines: 1,
      controller: controller,
      onChanged: (value) => onChanged,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    ),
  );
}