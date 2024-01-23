import 'package:flutter/material.dart';

AppBar buildAppBarWithArrowBack(
    {required String title, required void Function() onPressedAction}) {
  return AppBar(
    leading: IconButton(
      onPressed: onPressedAction,
      icon: const Icon(Icons.arrow_back_ios),
    ),
    title: Text(title),
  );
}
