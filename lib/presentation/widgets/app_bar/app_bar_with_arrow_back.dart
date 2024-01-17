import 'package:flutter/material.dart';

AppBar buildAppBarWithArrowBack({required String title}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back_ios),
    ),
    title: Text(title),
  );
}