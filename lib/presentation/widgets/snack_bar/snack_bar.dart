import 'package:flutter/material.dart';

SnackBar buildSnackBar(String message, Color bgrColor) {
  return SnackBar(
    content: Text(message),
    backgroundColor: bgrColor,
  );
}