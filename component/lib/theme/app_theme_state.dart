import 'package:component/theme/dimen/dimen.dart';
import 'package:component/theme/dimen/theme_dimen.dart';
import 'package:component/theme/dimen/twilight_red/twilight_red_dimen.dart';
import 'package:component/theme/utils/enums/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';
import 'colors/color_palette.dart';
import 'colors/twilight_red/twilight_red_color_palette.dart';
import 'text/app_text_theme.dart';
import 'utils/enums/design_system.dart';
import 'text/twilight_red/twilight_red_text_theme.dart';
import 'utils/extensions/design_system_extension.dart';

class AppThemeState {
  AppThemeState(
    this._appTheme,
    this._brightness,
    this._targetPlatform,
    this._appDimens,
  );

  final AppTheme _appTheme;
  final Brightness _brightness;
  final TargetPlatform _targetPlatform;
  final AppDimens _appDimens;

  factory AppThemeState.initial() {
    return AppThemeState(
      AppTheme(
        DesignSystem.twilight_red,
        TwilightRedTextTheme(),
        TwilightRedColorPalette(),
        TwilightRedDarkColorPalette(),
        TwilightRedDimen(),
      ),
      Brightness.light,
      TargetPlatform.android,
      AppDimens(ScreenSize.medium),
    );
  }

  AppThemeState copy({
    DesignSystem? designSystem,
    Brightness? brightness,
    TargetPlatform? targetPlatform,
    ScreenSize? screenSize,
  }) {
    AppTheme appTheme = this._appTheme;
    if (designSystem != null) {
      appTheme = AppTheme(
        designSystem,
        designSystem.getTextTheme(),
        designSystem.getLightColorPalette(),
        designSystem.getDarkColorPalette(),
        designSystem.getThemeDimen(),
      );
    }
    AppDimens appDimens = this._appDimens;
    if (screenSize != null) {
      appDimens = AppDimens(screenSize);
    }

    return AppThemeState(
      appTheme,
      brightness ?? this._brightness,
      targetPlatform ?? this._targetPlatform,
      appDimens,
    );
  }

  AppTheme getAppTheme() {
    return _appTheme;
  }

  ColorPalette getColorPalette() {
    if (_brightness == Brightness.dark) {
      return _appTheme.darkColorPalette;
    }
    return _appTheme.colorPalette;
  }

  AppTextTheme getTextTheme() {
    return _appTheme.appTextTheme;
  }

  ThemeDimen getAppThemeDimen() {
	  return _appTheme.themeDimen;
  }

  bool isAndroidDevice() {
    return _targetPlatform == TargetPlatform.android;
  }

  AppDimens getAppDimen() {
    return _appDimens;
  }

  DesignSystem getDesignSystem() {
	  return _appTheme.designSystem;
  }

  Brightness getBrightness() {
	  return _brightness;
  }

  TargetPlatform getTargetPlatform() {
	  return _targetPlatform;
  }
}

class AppThemeStateNotifier extends StateNotifier<AppThemeState> {
  AppThemeStateNotifier() : super(AppThemeState.initial());

  void setDesignSystem(DesignSystem designSystem) {
    state = state.copy(designSystem: designSystem);
  }

  void setBrightness(Brightness brightness) {
    state = state.copy(brightness: brightness);
  }

  void setTargetPlatform(TargetPlatform targetPlatform) {
    state = state.copy(targetPlatform: targetPlatform);
  }

  void setState(DesignSystem designSystem, Brightness brightness, TargetPlatform targetPlatform) {
    state = state.copy(
      designSystem: designSystem,
      brightness: brightness,
      targetPlatform: targetPlatform,
    );
  }
}
