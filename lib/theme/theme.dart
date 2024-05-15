import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_code_rag_frontend/theme/colors.dart';
import 'package:no_code_rag_frontend/theme/measures.dart';
import 'package:no_code_rag_frontend/theme/text.dart';

ThemeData primaryTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textTheme: GoogleFonts.interTextTheme().apply(bodyColor: colorWhite),
    appBarTheme: AppBarTheme(
        backgroundColor: colorPrimarySideBarBackground,
        elevation: 0,
        titleSpacing: 16,
        toolbarHeight: 64,
        titleTextStyle: textFontS18W400ColorW,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadiusOnlybLeft20bRight20)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 18, horizontal: 24)),
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(colorWhite),
      elevation: MaterialStateProperty.all<double>(0),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)))),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 18, horizontal: 24)),
      foregroundColor: MaterialStateProperty.all<Color>(colorWhite),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
              side: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.all(Radius.circular(4)))),
    )),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: primaryColor,
      contentTextStyle: TextStyle(color: colorWhite),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8))),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape:
          RoundedRectangleBorder(borderRadius: borderRadiusOnlytLeft20bRight20),
      backgroundColor: primaryColor,
    ));
