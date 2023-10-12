import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color greenColor = const Color(0xff61E757);
  static Color scaffoldBackgroundColorLight = const Color(0xffDFECDB);
  static Color redColor = const Color(0xffEC4B4B);
  static Color greyColor = const Color(0xffC8C9CB);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColorLightMode = const Color(0xff383838);
  static Color darkColorLightkMode = const Color(0xff363636);
  static Color blackColorDarkMode = const Color(0xff060E1E);
  static Color gradientColor = const Color(0xff56D7BC);
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,

    fontFamily: "Poppins",
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: whiteColor),
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    primaryColor: primaryColor,
    // useMaterial3: true,
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    bottomNavigationBarTheme: buildNavigationBarThemeDataLight(),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        color: blackColorLightMode,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: MyTheme.blackColorLightMode,
        fontSize: 16,

        // fontWeight: FontWeight.w700,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: "Poppins",
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: blackColorDarkMode),
    ),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: blackColorDarkMode,
    bottomNavigationBarTheme: buildNavigationBarThemeDataDark(),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: blackColorDarkMode,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        color: MyTheme.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: whiteColor,
        fontSize: 16,
        // fontWeight: FontWeight.w700,
      ),
    ),
  );

  //Bottom bar theme data LIGHT
  static BottomNavigationBarThemeData buildNavigationBarThemeDataLight() {
    return BottomNavigationBarThemeData(
      backgroundColor: whiteColor,
      showUnselectedLabels: false,
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
    );
  }

  //Bottom bar theme data DARK
  static BottomNavigationBarThemeData buildNavigationBarThemeDataDark() {
    return BottomNavigationBarThemeData(
      backgroundColor: blackColorDarkMode,
      showUnselectedLabels: false,
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
    );
  }
}
