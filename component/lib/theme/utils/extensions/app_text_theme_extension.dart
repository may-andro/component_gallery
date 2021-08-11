import 'package:component/theme/text/app_text_theme.dart';
import 'package:flutter/material.dart';

extension AppTextThemeExtension on AppTextTheme {
  TextTheme getTextTheme() => TextTheme(
        headline1: h1,
        headline2: h2,
        headline3: h3,
        headline4: h4,
        headline5: h5,
        headline6: h6,
        caption: caption,
        subtitle1: titlePrimary,
        subtitle2: titleSecondary,
        bodyText1: bodyPrimary,
        bodyText2: bodySecondary,
        overline: linkPrimary,
        button: bodyPrimary,
      );
}
