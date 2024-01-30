import 'package:flutter/material.dart';

buildDescriptionTextForm({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLines: 4,
      controller: controller,
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: hintText,
      ),
    ),
  );
}