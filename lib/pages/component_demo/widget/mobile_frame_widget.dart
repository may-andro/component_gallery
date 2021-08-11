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

class MobileFrameWidget extends StatelessWidget {
  const MobileFrameWidget({
    Key? key,
    required this.title,
    required this.height,
    required this.widget,
  }) : super(key: key);

  final String title;
  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appThemeState = context.read(appThemeStateProvider);
      final device = appThemeState.getTargetPlatform() == TargetPlatform.android ? Devices.android.pixel3: Devices.ios.iPhone11;
      return Theme(
        data: getThemeData(
          appThemeState.getColorPalette(),
          appThemeState.getBrightness(),
          appThemeState.getTextTheme(),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          height: height,
          child: DeviceFrame(
            device: device,
            isFrameVisible: true,
            orientation: Orientation.portrait,
            screen: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(title),
              ),
              body: Container(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: widget,
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
        backgroundColor: colorScheme.background,
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
