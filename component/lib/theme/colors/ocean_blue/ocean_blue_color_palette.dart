import 'package:flutter/material.dart';

import '../color_not_supported_error.dart';
import '../color_palette.dart';
import '../common_colors.dart';

class OceanBlueColorPalette implements ColorPalette {
  @override
  Color get primary => const Color(0xFF3F51B5);

  @override
  Color get primaryVariant => const Color(0xFF303F9F);

  @override
  Color get onPrimary => white;

  @override
  Color get secondary => const Color(0xFFE91E63);

  @override
  Color get secondaryVariant => const Color(0xFFC2185B);

  @override
  Color get onSecondary => white;

  @override
  Color get background => const Color(0xFFedf2f4);

  @override
  Color get onBackground => grey9;

  @override
  Color get error => const Color(0xFF540b0e);

  @override
  Color get onError => white;

  @override
  Color get surface => grey1;

  @override
  Color get onSurface => grey9;

  @override
  Color get disableColor => grey4;
}

class OceanBlueDarkColorPalette implements ColorPalette {
  @override
  Color get primary => const Color(0xFF7986CB);

  @override
  Color get primaryVariant => const Color(0xFF303F9F);

  @override
  Color get onPrimary => white;

  @override
  Color get secondary => const Color(0xFFF06292);

  @override
  Color get secondaryVariant => const Color(0xFFE91E63);

  @override
  Color get onSecondary => white;

  @override
  Color get background => grey9;

  @override
  Color get onBackground => white;

  @override
  Color get error => const Color(0xFFf77f00);

  @override
  Color get onError => grey9;

  @override
  Color get surface => grey7;

  @override
  Color get onSurface => white;

  @override
  Color get disableColor => grey7;
}
