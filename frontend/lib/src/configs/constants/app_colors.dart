import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class AppColors {
  AppColors._();

  static const MaterialColor primaryColor = MaterialColor(
    0xFF00465f,
    <int, Color>{
      50: Color(0xFF0080ad),
      100: Color(0xFF00719a),
      200: Color(0xFF006386),
      300: Color(0xFF005473),
      400: Color(0xFF00465f),
      500: Color(0xFF00384b),
      600: Color(0xFF002938),
      700: Color(0xFF001b24),
      800: Color(0xFF000c11),
      900: Color(0xFF000c11),
    },
  );
  static const Color secondaryColor = Color(0xFF00465f);
  static final Color successColor = HexColor('#28a745');
  static final Color errorColor = HexColor('#dc3545');
  static final Color infoColor = HexColor('#2CA8FF');
  static final Color warningColor = HexColor('#ffc107');
  static final Color placeholderColor = HexColor('#9FA5AA');
  static final Color borderColor = HexColor('#CAD1D7');
  static final Color appBarForegroundColor = HexColor("#34506A");
}
