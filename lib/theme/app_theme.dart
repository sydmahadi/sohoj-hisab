import 'package:flutter/material.dart';

class AppTheme {
  // Premium Islamic Dark Colors
  static const Color primary = Color(0xFF0F5132);
  static const Color primaryLight = Color(0xFF176B45);

  static const Color background = Color(0xFF06130F);
  static const Color backgroundSecondary = Color(0xFF0A1E17);

  static const Color card = Color(0xFF0D251C);
  static const Color cardLight = Color(0xFF123225);

  static const Color gold = Color(0xFFC9A45C);
  static const Color goldLight = Color(0xFFE4C987);

  static const Color textDark = Color(0xFFF2EBDD);
  static const Color textMuted = Color(0xFF9DAEA5);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: primaryLight,
        secondary: gold,
        surface: card,
        onSurface: textDark,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textDark,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
            color: gold,
            width: 0.5,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),

        labelStyle: const TextStyle(
          color: textMuted,
        ),

        hintStyle: const TextStyle(
          color: Color(0xFF71837A),
        ),

        prefixIconColor: gold,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: gold,
            width: 0.5,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: gold,
            width: 0.5,
          ),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(17),
          ),
          borderSide: BorderSide(
            color: gold,
            width: 1.4,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: Colors.white,
          minimumSize: const Size(
            double.infinity,
            54,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: textDark,
        ),
        bodyMedium: TextStyle(
          color: textMuted,
        ),
        titleLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
