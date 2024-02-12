import 'package:flutter/material.dart';

class AppProperty{
  /// BorderRadius
  static final allBorderRadiusSmall =  BorderRadius.circular(10);
  static final allBorderRadiusMediumSmall =  BorderRadius.circular(15);
  static final allBorderRadiusMedium =  BorderRadius.circular(20);
  static final allBorderRadiusLarge =  BorderRadius.circular(45);
  static final allBorderRadiusExtraLarge =  BorderRadius.circular(50);
  static final allBorderRadiusExtraExtraLarge =  BorderRadius.circular(70);

  static const topRightTopLeftBorderRadiusMedium =  BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  );


}