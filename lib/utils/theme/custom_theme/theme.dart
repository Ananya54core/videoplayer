import 'package:flutter/material.dart';
import 'package:videoplayer/utils/theme/custom_theme/text_theme.dart';

import 'appbartheme.dart';
import 'bottom_sheettheme.dart';
import 'checkboxtheme.dart';
import 'chip_theme.dart';
import 'elevatedbuttontheme.dart';
import 'inputdecoration.dart';
import 'outlinetheme.dart';
class VAppTheme{
  VAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    primaryColor: Colors.deepOrangeAccent,
    scaffoldBackgroundColor: Colors.white,
    textTheme: VTextTheme.lightTextTheme,
    elevatedButtonTheme: VElevatedButtonTheme.lightElevatedButton,
    appBarTheme: VAppBarTheme.LightAppBarTheme,
    checkboxTheme:  VCheckboxTheme.lightCheckboxThemeData,
    bottomSheetTheme: VBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: VOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: VInputDecorationTheme.lightInputDecorationTheme,
    chipTheme: VChipTheme.lightChipTheme,

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrangeAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: VTextTheme.darkTextTheme,
    elevatedButtonTheme: VElevatedButtonTheme.darkElevatedButton,
    appBarTheme: VAppBarTheme.darkAppBarTheme,
    checkboxTheme:  VCheckboxTheme.darkCheckboxThemeData,
    bottomSheetTheme: VBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: VOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: VInputDecorationTheme.darkInputDecorationTheme,
    chipTheme: VChipTheme.DarkChipTheme,
  );
}


