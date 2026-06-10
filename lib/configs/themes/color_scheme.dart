import 'package:flutter/material.dart';

// ─── Light: Warm Library – Amber / Brown / Cream ───────────────────────────
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Primary = Warm Amber Brown (màu gỗ thư viện)
  primary: Color(0xFF8B4513),          // SaddleBrown
  onPrimary: Color(0xFFFFFFFF),

  primaryContainer: Color(0xFFFFE4C4),  // Bisque
  onPrimaryContainer: Color(0xFF5C2A0D),

  // Secondary = Deep Amber
  secondary: Color(0xFFD2691E),         // Chocolate
  onSecondary: Color(0xFFFFFFFF),

  secondaryContainer: Color(0xFFFFF3E0), // Amber-50
  onSecondaryContainer: Color(0xFF8B4513),

  // Tertiary = Forest Green (màu lá cây trong thư viện)
  tertiary: Color(0xFF2E7D32),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC8E6C9),
  onTertiaryContainer: Color(0xFF1B5E20),

  // Error
  error: Color(0xFFB71C1C),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFCDD2),
  onErrorContainer: Color(0xFF7F0000),

  // Outline
  outline: Color(0xFFBCAAA4),           // warm gray
  outlineVariant: Color(0xFFEFEBE9),    // warm gray-50

  // Surface = warm cream
  surface: Color(0xFFFFF8F0),           // warm cream background
  onSurface: Color(0xFF3E2723),         // deep warm brown text
  surfaceContainerHighest: Color(0xFFF5E6D3), // warm card bg
  onSurfaceVariant: Color(0xFF6D4C41),  // medium brown text

  // Inverse
  inverseSurface: Color(0xFF3E2723),
  onInverseSurface: Color(0xFFFBE9E7),
  inversePrimary: Color(0xFFFFB74D),

  // Misc
  shadow: Color(0xFF795548),
  surfaceTint: Color(0xFF8B4513),
  scrim: Color(0xFF000000),
);

// ─── Dark: Warm Dark Library – Deep Mahogany ───────────────────────────────
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Primary = Warm Amber glow
  primary: Color(0xFFFFB74D),           // Amber-300
  onPrimary: Color(0xFF3E2000),

  primaryContainer: Color(0xFF5D3200),
  onPrimaryContainer: Color(0xFFFFDDB2),

  // Secondary
  secondary: Color(0xFFFFCC80),         // Amber-200
  onSecondary: Color(0xFF452B00),

  secondaryContainer: Color(0xFF5D3E00),
  onSecondaryContainer: Color(0xFFFFE0B2),

  // Tertiary = warm green
  tertiary: Color(0xFF81C784),
  onTertiary: Color(0xFF1B5E20),
  tertiaryContainer: Color(0xFF2E7D32),
  onTertiaryContainer: Color(0xFFC8E6C9),

  // Error
  error: Color(0xFFFF8A80),
  onError: Color(0xFF4A0000),
  errorContainer: Color(0xFF7F0000),
  onErrorContainer: Color(0xFFFFCDD2),

  // Outline
  outline: Color(0xFF6D4C41),
  outlineVariant: Color(0xFF4E342E),

  // Surface = deep mahogany dark
  surface: Color(0xFF1A0F00),           // very dark warm brown
  onSurface: Color(0xFFEFEBE9),
  surfaceContainerHighest: Color(0xFF2D1A00), // warm dark card
  onSurfaceVariant: Color(0xFFD7CCC8),

  // Inverse
  inverseSurface: Color(0xFFEFEBE9),
  onInverseSurface: Color(0xFF1A0F00),
  inversePrimary: Color(0xFF8B4513),

  // Misc
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFB74D),
  scrim: Color(0xFF000000),
);
