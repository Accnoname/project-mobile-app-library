import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/color_scheme.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';

class AppTheme {
  static final darkTextStyle = TextStyle(color: lightColorScheme.onPrimary);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    textTheme: TextTheme(
      bodyLarge: darkTextStyle,
      bodyMedium: darkTextStyle,
      bodySmall: darkTextStyle,
      displayLarge: darkTextStyle,
      displayMedium: darkTextStyle,
      displaySmall: darkTextStyle,
      headlineLarge: darkTextStyle,
      headlineMedium: darkTextStyle,
      headlineSmall: darkTextStyle,
      labelLarge: darkTextStyle,
      labelMedium: darkTextStyle,
      labelSmall: darkTextStyle,
      titleLarge: darkTextStyle,
      titleMedium: darkTextStyle,
      titleSmall: darkTextStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onSecondary,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    fontFamily: 'Satoshi',
    textTheme: TextTheme(
      bodyLarge: darkTextStyle,
      bodyMedium: darkTextStyle,
      bodySmall: darkTextStyle,
      displayLarge: darkTextStyle,
      displayMedium: darkTextStyle,
      displaySmall: darkTextStyle,
      headlineLarge: darkTextStyle,
      headlineMedium: darkTextStyle,
      headlineSmall: darkTextStyle,
      labelLarge: darkTextStyle,
      labelMedium: darkTextStyle,
      labelSmall: darkTextStyle,
      titleLarge: darkTextStyle,
      titleMedium: darkTextStyle,
      titleSmall: darkTextStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
        backgroundColor: WidgetStatePropertyAll(darkColorScheme.secondary),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: Gap.md, horizontal: Gap.lg),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: radius12,
            side: BorderSide(color: darkColorScheme.inverseSurface, width: 1),
          ),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: Gap.md, horizontal: Gap.lg),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: radius12,
            side: BorderSide(color: darkColorScheme.onPrimary, width: 1),
          ),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkColorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: darkColorScheme.onPrimary),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.secondary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.onPrimary;
        }
        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.tertiaryContainer;
        }
        return Colors.grey.withAlpha(130);
      }),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.withAlpha(130),
      selectionHandleColor: Colors.blue,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return darkColorScheme.secondary;
        }
        return darkColorScheme.onPrimary;
      }),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedIconColor: darkColorScheme.onPrimary,
      iconColor: darkColorScheme.onPrimary,
    ),
  );
}
