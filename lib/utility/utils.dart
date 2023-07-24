import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Utils {
  static normalTextStyle({color, size, fontWeight}) => TextStyle(
      color: color ?? AppColors.white,
      fontSize: size ?? 16.0,
      fontWeight: fontWeight ?? FontWeight.normal);

  static double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}
