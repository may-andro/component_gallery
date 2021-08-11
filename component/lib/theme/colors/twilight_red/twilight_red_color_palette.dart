import 'package:flutter/material.dart';

import '../color_palette.dart';
import '../common_colors.dart';

class TwilightRedColorPalette implements ColorPalette {
  @override
  Color get primary => const Color(0xFFD32F2F);

  @override
  Color get primaryVariant => const Color(0xFFF44336);

  @override
  Color get onPrimary => white;

  @override
  Color get secondary => const Color(0xFF673AB7);

  @override
  Color get secondaryVariant => const Color(0xFF9575CD);

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

class TwilightRedDarkColorPalette implements ColorPalette {
  @override
  Color get primary => const Color(0xFFD32F2F);

  @override
  Color get primaryVariant => const Color(0xFFEF9A9A);

  @override
  Color get onPrimary => white;

  @override
  Color get secondary => const Color(0xFF7C4DFF);

  @override
  Color get secondaryVariant => const Color(0xFFB388FF);

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
