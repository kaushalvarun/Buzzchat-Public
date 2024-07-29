import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(color: Color(0xFFDDEBE9)),
    primaryColor: const Color(0xFFE9F1F0),
    fontFamily: GoogleFonts.roboto().fontFamily,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFE9F1F0),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xFF11999E)),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF11999E),
      contentTextStyle: TextStyle(
        color: Color(0xFFE9F1F0),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      actionTextColor: Color(0xFF11999E),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xFF11999E)),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color.fromARGB(255, 75, 126, 117),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      actionTextColor: Colors.white,
    ),
  );

// dark mode
  static Color darkButtonColor = const Color(0xFF076E72);
  static Color darkMessageCurrentUserColor = const Color(0xFF8BB7B8);
  static Color darkMessageNotCurrentUserColor = const Color(0xFFC2C2C2);
  static Color darkReadMoreCurrentUserColor =
      const Color.fromARGB(255, 0, 0, 0);
  static Color darkReadMoreNotCurrentUserColor =
      const Color.fromARGB(255, 32, 10, 83);

  static Color darkSecondaryColor = const Color(0xFF8BB7B8);
  static Color darkTextColor = const Color(0xFF343434);

// light mode
  static Color buttonColor = const Color(0xFF076E72);
  static Color messageCurrentUserColor = const Color(0xFFB7D7D8);
  static Color messageNotCurrentUserColor = const Color(0xFFE8E7E7);
  static Color readMoreCurrentUserColor = const Color.fromARGB(255, 0, 0, 0);
  static Color readMoreNotCurrentUserColor =
      const Color.fromARGB(255, 32, 10, 83);

  static Color secondaryColor = const Color(0xFF8BB7B8);
  static Color textColor = const Color(0xFF343434);

  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
