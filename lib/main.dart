import 'package:flutter/material.dart';
import 'package:home_info/core/themes/app_theme.dart';

void main() {
  runApp(const HomeInfoApp());
}

class HomeInfoApp extends StatelessWidget {
  const HomeInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeInfo',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: Container(color: Colors.red,),
    );
  }
}
