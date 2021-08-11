import 'package:component/theme/colors/color_palette.dart';
import 'package:component/theme/utils/enums/design_system.dart';
import 'package:component/theme/text/app_text_theme.dart';

import 'dimen/theme_dimen.dart';

class AppTheme {
  final DesignSystem designSystem;
  final ColorPalette colorPalette;
  final ColorPalette darkColorPalette;
  final AppTextTheme appTextTheme;
  final ThemeDimen themeDimen;

  AppTheme(
    this.designSystem,
    this.appTextTheme,
    this.colorPalette,
    this.darkColorPalette,
    this.themeDimen,
  );
}
