import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';

class ThemeType {
  ThemeData lightMode() {
    ThemeData data = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: whiteColor,
        elevation: 2,
        iconTheme: IconThemeData(
          color: greenColor,
          size: 25,
        ),
        actionsIconTheme: IconThemeData(
          color: greenColor,
          size: 25,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: whiteColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          // systemNavigationBarColor: Colors.white,
          // systemNavigationBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.w800,
          fontSize: xf,
        ),
      ),
      backgroundColor: whiteColor,
      scaffoldBackgroundColor: whiteColor,
      brightness: Brightness.light,
      drawerTheme: DrawerThemeData(
        backgroundColor: whiteColor,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        textColor: greenColor,
        dense: true,
        iconColor: greenColor,
      ),
      cardTheme: CardTheme(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: whiteColor,
        brightness: Brightness.light,
        labelStyle: TextStyle(
          fontSize: lf,
          decoration: TextDecoration.none,
          color: greenColor,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: greenColor,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      iconTheme: IconThemeData(
        color: greenColor,
        size: 25,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 0.5,
            color: greyColor3,
          ),
        ),
        labelStyle: TextStyle(
          color: blackColor,
          fontSize: mf,
        ),
        hintStyle: TextStyle(
          color: greyColor2,
          fontSize: mf,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(
          // backgroundColor: Colors.white,
          decoration: TextDecoration.none,
          color: greenColor,
        ),
        caption: TextStyle(
          fontSize: xf,
          decoration: TextDecoration.none,
          color: mainColor,
        ),
        headline1: TextStyle(
          fontSize: xf,
          decoration: TextDecoration.none,
          color: mainColor,
        ),
        headline2: TextStyle(
          fontSize: xf,
          decoration: TextDecoration.none,
          color: mainColor,
        ),
        headline3: TextStyle(
          fontSize: lf,
          decoration: TextDecoration.none,
          color: greenColor,
        ),
        headline4: TextStyle(
          fontSize: mf,
          decoration: TextDecoration.none,
          color: greenColor,
        ),
        headline5: TextStyle(
          fontSize: sf,
          decoration: TextDecoration.none,
          color: greenColor,
        ),
        bodyText1: TextStyle(
          fontSize: lf,
          decoration: TextDecoration.none,
          color: blackColor,
        ),
        bodyText2: TextStyle(
          fontSize: mf,
          decoration: TextDecoration.none,
          color: greyColor1,
        ),
        subtitle1: TextStyle(
          fontSize: mf,
          decoration: TextDecoration.none,
          color: greyColor1,
        ),
        subtitle2: TextStyle(
          fontSize: sf,
          decoration: TextDecoration.none,
          color: greyColor1,
        ),
      ),
    );
    return data;
  }

  ThemeData darkMode() {
    ThemeData data = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorMain,
        elevation: 2,
        iconTheme: IconThemeData(
          color: whiteColor,
          size: 25,
        ),
        actionsIconTheme: IconThemeData(
          color: whiteColor,
          size: 25,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkColorMain,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          // systemNavigationBarColor: Colors.white,
          // systemNavigationBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.w800,
          fontSize: xf,
        ),
      ),
      backgroundColor: darkColor1,
      scaffoldBackgroundColor: darkColor1,
      brightness: Brightness.dark,
      drawerTheme: DrawerThemeData(
        backgroundColor: darkColor1,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        textColor: whiteColor,
        dense: true,
        iconColor: whiteColor,
      ),
      cardTheme: CardTheme(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        color: darkColor2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkColor2,
        brightness: Brightness.dark,
        labelStyle: TextStyle(
          fontSize: lf,
          decoration: TextDecoration.none,
          color: whiteColor,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: whiteColor,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      iconTheme: IconThemeData(
        color: whiteColor,
        size: 25,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 0.5,
            color: greyColor3,
          ),
        ),
        labelStyle: TextStyle(
          color: whiteColor,
          fontSize: mf,
        ),
        hintStyle: TextStyle(
          color: greyColor3,
          fontSize: mf,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(
          // backgroundColor: Colors.white,
          decoration: TextDecoration.none,
          color: greenColor,
        ),
        caption: TextStyle(
          fontSize: xf,
          decoration: TextDecoration.none,
          color: mainColor,
        ),
        headline1: TextStyle(
          fontSize: xf,
          decoration: TextDecoration.none,
          color: mainColor,
        ),
        headline2: TextStyle(
          fontSize: xf,
          decoration: TextDecoration.none,
          color: whiteColor,
        ),
        headline3: TextStyle(
          fontSize: lf,
          decoration: TextDecoration.none,
          color: whiteColor,
        ),
        headline4: TextStyle(
          fontSize: mf,
          decoration: TextDecoration.none,
          color: whiteColor.withOpacity(0.8),
        ),
        headline5: TextStyle(
          fontSize: sf,
          decoration: TextDecoration.none,
          color: whiteColor,
        ),
        bodyText1: TextStyle(
          fontSize: lf,
          decoration: TextDecoration.none,
          color: whiteColor,
        ),
        bodyText2: TextStyle(
          fontSize: mf,
          decoration: TextDecoration.none,
          color: greyColor2,
        ),
        subtitle1: TextStyle(
          fontSize: mf,
          decoration: TextDecoration.none,
          color: greyColor3,
        ),
        subtitle2: TextStyle(
          fontSize: sf,
          decoration: TextDecoration.none,
          color: greyColor3,
        ),
      ),
    );
    return data;
  }
}
