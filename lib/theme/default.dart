import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var theme = ThemeData(
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(57, 174, 200, 1),
    size: 24,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 10.sp,
      color: buttonTextColor,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 8.sp,
      color: textBrownColor,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 8.sp,
      color: textBeigeColor,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 8.sp,
      color: buttonTextColor,
      fontWeight: FontWeight.w400,
    ),
  ),
);

const color1 = Color.fromRGBO(57, 174, 200, 1);
const color2 = Color.fromRGBO(71, 200, 228, 1);
const color3 = Color.fromRGBO(228, 128, 71, 1);
const textBrownColor = Color.fromRGBO(131, 81, 72, 1);
const textBeigeColor = Color.fromRGBO(255, 238, 194, 1);
const buttonTextColor = Color.fromRGBO(254, 220, 119, 1);
