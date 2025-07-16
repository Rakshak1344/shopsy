import 'package:flutter/material.dart';
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF101C1D);
  static const Color onPrimary = Colors.white;
  static const Color primaryContainer = Color(0xFFEFF2F3);
  static const Color onPrimaryContainer = Color(0xFF101C1D);

  static const Color secondary = Color(0xFF28A745);
  static const Color onSecondary = Colors.white;
  static const Color secondaryContainer = Color(0xFFDFF5E3);
  static const Color onSecondaryContainer = Color(0xFF1A7F31);

  static const Color tertiary = Color(0xFF6E6E6E);
  static const Color onTertiary = Colors.white;
  static const Color tertiaryContainer = Color(0xFFE0E0E0);
  static const Color onTertiaryContainer = Color(0xFF1A1A1A);

  static const Color error = Color(0xFFCC0000);
  static const Color onError = Colors.white;
  static const Color errorContainer = Color(0xFFFFE5E5);
  static const Color onErrorContainer = Color(0xFF800000);

  static const Color surface = Colors.white;
  static const Color onSurface = Color(0xFF1A1A1A);

  static const Color surfaceContainerHighest = Color(0xFFF8F8F8); // Background
  static const Color surfaceContainerHigh = Color(0xFFF2F2F2);
  static const Color surfaceContainer = Color(0xFFECECEC);
  static const Color surfaceContainerLow = Color(0xFFE6E6E6);
  static const Color surfaceContainerLowest = Color(0xFFE0E0E0); // App Scaffold BG

  static const Color outline = Color(0xFFE0E0E0);
  static const Color inverseSurface = Color(0xFF1A1A1A);
  static const Color onInverseSurface = Colors.white;

  static const Color shadow = Colors.black12;
  static const Color scrim = Colors.black12;
  static const Color surfaceTint = primary;

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceContainerHighest,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainer: surfaceContainer,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainerLowest: surfaceContainerLowest,
    outline: outline,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    shadow: shadow,
    scrim: scrim,
    surfaceTint: surfaceTint,
  );

  static final ColorScheme dark = light.copyWith(
    brightness: Brightness.dark,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
    inverseSurface: Colors.white,
    onInverseSurface: Color(0xFF1A1A1A),
    surfaceContainerHighest: Color(0xFF121212),
    surfaceContainerLowest: Color(0xFF0A0A0A),
  );
}
