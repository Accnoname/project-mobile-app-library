import 'package:flutter/material.dart';

// ─── Light: Clean White + Navy/Indigo accent ───────────────────────────────
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Primary = Navy Indigo
  primary: Color(0xFF3B5BDB),          // indigo-600
  onPrimary: Color(0xFFFFFFFF),

  primaryContainer: Color(0xFFDBE4FF),  // indigo-100
  onPrimaryContainer: Color(0xFF1A237E),

  // Secondary = Soft slate
  secondary: Color(0xFF748FFC),         // indigo-400 (hover accent)
  onSecondary: Color(0xFFFFFFFF),

  secondaryContainer: Color(0xFFEEF2FF), // indigo-50
  onSecondaryContainer: Color(0xFF364FC7),

  // Tertiary = Teal success
  tertiary: Color(0xFF0CA678),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFD3F9D8),
  onTertiaryContainer: Color(0xFF0B7A57),

  // Error
  error: Color(0xFFE03131),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFE3E3),
  onErrorContainer: Color(0xFFC92A2A),

  // Outline
  outline: Color(0xFFCED4DA),
  outlineVariant: Color(0xFFE9ECEF),

  // Surface
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF212529),
  surfaceContainerHighest: Color(0xFFF1F3F9),
  onSurfaceVariant: Color(0xFF6C757D),

  // Inverse
  inverseSurface: Color(0xFF1C1F2E),
  onInverseSurface: Color(0xFFE9ECEF),
  inversePrimary: Color(0xFF748FFC),

  // Misc
  shadow: Color(0xFF868E96),
  surfaceTint: Color(0xFF3B5BDB),
  scrim: Color(0xFF000000),
);

// ─── Dark: Deep Navy + Indigo accent ───────────────────────────────────────
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Primary = Indigo glow
  primary: Color(0xFF4C6EF5),
  onPrimary: Color(0xFFFFFFFF),

  primaryContainer: Color(0xFF2C3476),
  onPrimaryContainer: Color(0xFFDBE4FF),

  // Secondary
  secondary: Color(0xFF748FFC),
  onSecondary: Color(0xFFFFFFFF),

  secondaryContainer: Color(0xFF2C3476),
  onSecondaryContainer: Color(0xFFDBE4FF),

  // Tertiary = Teal
  tertiary: Color(0xFF12B886),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF087F5B),
  onTertiaryContainer: Color(0xFFD3F9D8),

  // Error
  error: Color(0xFFFF6B6B),
  onError: Color(0xFF1C1F2E),
  errorContainer: Color(0xFF7C1D1D),
  onErrorContainer: Color(0xFFFFE3E3),

  // Outline
  outline: Color(0xFF495057),
  outlineVariant: Color(0xFF343A40),

  // Surface = deep navy
  surface: Color(0xFF141520),
  onSurface: Color(0xFFE9ECEF),
  surfaceContainerHighest: Color(0xFF1E2130),
  onSurfaceVariant: Color(0xFFADB5BD),

  // Inverse
  inverseSurface: Color(0xFFE9ECEF),
  onInverseSurface: Color(0xFF141520),
  inversePrimary: Color(0xFF3B5BDB),

  // Misc
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4C6EF5),
  scrim: Color(0xFF000000),
);
