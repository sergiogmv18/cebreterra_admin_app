import 'package:flutter/material.dart';

class CebreterraStyle {
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: CustomColors.colorFront,
   // timePickerTheme: _timePickerTheme,
    primaryColorDark:  CustomColors.colorDark,
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: CustomColors.colorDark),
    dialogBackgroundColor:  CustomColors.colorFront,
    cardColor: CustomColors.colorFront,
    canvasColor: CustomColors.colorFront,
    dividerColor: CustomColors.colorDark,
    disabledColor: CustomColors.colorDark,
    iconTheme: IconThemeData(color:  CustomColors.colorDark),
  );
}

class CustomColors {
  static Color pantone5615 = Color.fromRGBO((255 * (1 - 0.65) * (1 - 0.24)).round(),(255 * (1 - 0.36) * (1 - 0.24)).round(), (255 * (1 - 0.56) * (1 - 0.24)).round(), 1.0);
  static Color colorDark = Colors.black;
  static Color colorFront = Colors.white;
  static Color activeButtonColor = Colors.green;
  static Color backgroundColorInput = Colors.grey;
  static Color cancelActionButtonColor = Colors.red;
  static Color tableColor = const Color(0xffd1d0ce);
  static Color tableColor2 = const Color(0xffc4bcb1);
  static Color tableColor3 = const Color(0xffd9d6cf);
  static Color tableColor4 = const Color(0xfff7f6f4);
  static Color displayColor = const Color(0xffefeff4);
  static Color pantone720 = const Color(0xff8c573a);
  static Color kSecondaryColor =const Color(0xFFfe5722); //secondary color
}