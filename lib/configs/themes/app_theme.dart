import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/color_scheme.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';

class AppTheme {
  // ─── Shared text styles ───────────────────────────────────────────────────
  // Using system default font (Roboto on Android, SF Pro on iOS, Segoe UI on Windows)
  static const String? _fontFamily = null;

  static TextTheme _buildTextTheme(Color color) => TextTheme(
        displayLarge: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontFamily: _fontFamily, color: color),
        bodyMedium: TextStyle(fontFamily: _fontFamily, color: color),
        bodySmall: TextStyle(fontFamily: _fontFamily, color: color),
        labelLarge: TextStyle(fontFamily: _fontFamily, color: color, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontFamily: _fontFamily, color: color),
        labelSmall: TextStyle(fontFamily: _fontFamily, color: color),
      );

  // ─── Light Theme ─────────────────────────────────────────────────────────
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    fontFamily: _fontFamily,
    textTheme: _buildTextTheme(lightColorScheme.onSurface),
    scaffoldBackgroundColor: const Color(0xFFF8F9FE),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // Card
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: radius16,
        side: const BorderSide(color: Color(0xFFE9ECEF), width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: lightColorScheme.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: radius12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        side: BorderSide(color: lightColorScheme.primary, width: 1.5),
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: radius12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),

    // InputDecoration (TextField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF1F3F9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: const BorderSide(color: Color(0xFFE9ECEF), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: BorderSide(color: lightColorScheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: const BorderSide(color: Color(0xFFE03131), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: const BorderSide(color: Color(0xFFE03131), width: 1.5),
      ),
      labelStyle: const TextStyle(
        fontFamily: _fontFamily,
        color: Color(0xFF6C757D),
        fontSize: 14,
      ),
      hintStyle: const TextStyle(
        fontFamily: _fontFamily,
        color: Color(0xFFADB5BD),
        fontSize: 14,
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: lightColorScheme.primary,
      unselectedItemColor: const Color(0xFF9FA8B5),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 11,
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: radius16),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE9ECEF),
      thickness: 1,
      space: 1,
    ),

    // ListTile
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return lightColorScheme.primary;
        return const Color(0xFFCED4DA);
      }),
    ),

    // TabBar
    tabBarTheme: TabBarThemeData(
      labelColor: lightColorScheme.primary,
      unselectedLabelColor: const Color(0xFF9FA8B5),
      indicatorColor: lightColorScheme.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
      ),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return lightColorScheme.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStatePropertyAll(Colors.white),
      side: const BorderSide(color: Color(0xFFCED4DA), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // TextSelection
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: lightColorScheme.primary.withOpacity(0.2),
      selectionHandleColor: lightColorScheme.primary,
      cursorColor: lightColorScheme.primary,
    ),

    useMaterial3: true,
  );

  // ─── Dark Theme ───────────────────────────────────────────────────────────
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    fontFamily: _fontFamily,
    textTheme: _buildTextTheme(darkColorScheme.onSurface),
    scaffoldBackgroundColor: const Color(0xFF0F1117),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF141520),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // Card
    cardTheme: CardThemeData(
      color: const Color(0xFF1E2130),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: radius16,
        side: const BorderSide(color: Color(0xFF2C3248), width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: darkColorScheme.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: radius12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkColorScheme.primary,
        side: BorderSide(color: darkColorScheme.primary, width: 1.5),
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: radius12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),

    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E2130),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: const BorderSide(color: Color(0xFF2C3248), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: BorderSide(color: darkColorScheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius12,
        borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
      ),
      labelStyle: const TextStyle(
        fontFamily: _fontFamily,
        color: Color(0xFFADB5BD),
        fontSize: 14,
      ),
      hintStyle: const TextStyle(
        fontFamily: _fontFamily,
        color: Color(0xFF6C757D),
        fontSize: 14,
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF141520),
      selectedItemColor: darkColorScheme.primary,
      unselectedItemColor: const Color(0xFF6C757D),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 11,
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkColorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: radius16),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2C3248),
      thickness: 1,
      space: 1,
    ),

    // ListTile
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return darkColorScheme.primary;
        return const Color(0xFF2C3248);
      }),
    ),

    // TabBar
    tabBarTheme: TabBarThemeData(
      labelColor: darkColorScheme.primary,
      unselectedLabelColor: const Color(0xFF6C757D),
      indicatorColor: darkColorScheme.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
      ),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) return darkColorScheme.primary;
        return Colors.transparent;
      }),
      checkColor: const WidgetStatePropertyAll(Colors.white),
      side: const BorderSide(color: Color(0xFF495057), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // TextSelection
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: darkColorScheme.primary.withOpacity(0.3),
      selectionHandleColor: darkColorScheme.primary,
      cursorColor: darkColorScheme.primary,
    ),

    // BottomSheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E2130),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Expansion Tile
    expansionTileTheme: const ExpansionTileThemeData(
      collapsedIconColor: Color(0xFFADB5BD),
      iconColor: Color(0xFF4C6EF5),
    ),

    useMaterial3: true,
  );
}
