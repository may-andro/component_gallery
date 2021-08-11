import 'package:component/theme/colors/color_palette.dart';
import 'package:flutter/material.dart';

extension ColorPaletteExtension on ColorPalette {
  ColorScheme getColorScheme(Brightness brightness) => ColorScheme(
        primary: primary,
        primaryVariant: primaryVariant,
        secondary: secondary,
        secondaryVariant: secondaryVariant,
        surface: surface,
        background: background,
        error: error,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onBackground: onBackground,
        onError: onError,
        brightness: brightness,
      );
}
