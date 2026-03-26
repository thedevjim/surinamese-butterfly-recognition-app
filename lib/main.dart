import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vlinder Herkenning',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      home: const MainNavigation(),
    );
  }

  ThemeData _buildLightTheme() {
    final baseTextTheme = GoogleFonts.openSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0364E9),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: Colors.black87,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: Colors.black87,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: Colors.black54,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          color: Colors.black87,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          color: Colors.black54,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.openSans(
          color: const Color(0xFF0364E9),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0364E9),
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF0364E9),
      ),
    );
  }
}
