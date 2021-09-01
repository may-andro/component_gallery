import 'package:component/theme/colors/color_palette.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:component/theme/app_theme_provider.dart';
import 'package:component/theme/utils/extensions/color_palette_extension.dart';
import 'package:component/theme/utils/extensions/app_text_theme_extension.dart';
import 'package:component/theme/text/app_text_theme.dart';

class MobilePhoneWidget extends StatelessWidget {
  const MobilePhoneWidget({
    Key? key,
    required this.appBarTitle,
    required this.previewWidget,
    required this.deviceInfo,
  }) : super(key: key);

  final String appBarTitle;
  final Widget previewWidget;
  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appThemeState = context.read(appThemeStateProvider);
      return Theme(
        data: getThemeData(
          appThemeState.getColorPalette(),
          appThemeState.getBrightness(),
          appThemeState.getTextTheme(),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: DeviceFrame(
            device: deviceInfo,
            isFrameVisible: true,
            orientation: Orientation.portrait,
            screen: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(appBarTitle),
              ),
              body: Container(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: previewWidget,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  ThemeData getThemeData(ColorPalette colorPalette, Brightness brightness, AppTextTheme appTextTheme) {
    final colorScheme = colorPalette.getColorScheme(brightness);
    return ThemeData(
      colorScheme: colorPalette.getColorScheme(brightness),
      textTheme: appTextTheme.getTextTheme(),
      // Matches manifest.json colors and background color.
      primaryColor: colorPalette.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
    );
  }
}
