import 'package:component/theme/colors/color_palette.dart';
import 'package:component/theme/colors/ocean_blue/ocean_blue_color_palette.dart';
import 'package:component/theme/colors/twilight_red/twilight_red_color_palette.dart';
import 'package:component/theme/dimen/ocean_blue/ocean_blue_dimen.dart';
import 'package:component/theme/dimen/theme_dimen.dart';
import 'package:component/theme/dimen/twilight_red/twilight_red_dimen.dart';
import 'package:component/theme/utils/enums/design_system.dart';
import 'package:component/theme/text/app_text_theme.dart';
import 'package:component/theme/text/ocean_blue/ocean_blue_text_theme.dart';
import 'package:component/theme/text/twilight_red/twilight_red_text_theme.dart';

extension DesignSystemExtension on DesignSystem {
  AppTextTheme getTextTheme() {
    if (this == DesignSystem.ocean_blue) {
      return OceanBlueTextTheme();
    }

    if (this == DesignSystem.twilight_red) {
      return TwilightRedTextTheme();
    }

    throw UnimplementedError();
  }

  ThemeDimen getThemeDimen() {
    if (this == DesignSystem.ocean_blue) {
      return OceanBlueDimen();
    }

    if (this == DesignSystem.twilight_red) {
      return TwilightRedDimen();
    }

    throw UnimplementedError();
  }

  ColorPalette getLightColorPalette() {
    if (this == DesignSystem.ocean_blue) {
      return OceanBlueColorPalette();
    }

    if (this == DesignSystem.twilight_red) {
      return TwilightRedDarkColorPalette();
    }

    throw UnimplementedError();
  }

  ColorPalette getDarkColorPalette() {
    if (this == DesignSystem.ocean_blue) {
      return OceanBlueDarkColorPalette();
    }

    if (this == DesignSystem.twilight_red) {
      return TwilightRedColorPalette();
    }

    throw UnimplementedError();
  }
}
