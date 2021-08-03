import 'package:component_gallery/app/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileViewWidget extends StatelessWidget {
  const MobileViewWidget({
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
      final appState = context.read(appStateProvider);
      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        height: height,
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10.0),
            bottom: Radius.circular(2.0),
          ),
          child: Theme(
            data: MaterialDemoThemeData.themeData.copyWith(
              platform: appState.getComponentGalleryOptions().platform,
            ),
            child: Scaffold(
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
}

class MaterialDemoThemeData {
  static final themeData = ThemeData(
    colorScheme: _colorScheme,
    appBarTheme: AppBarTheme(
      color: _colorScheme.primary,
      iconTheme: IconThemeData(color: _colorScheme.onPrimary),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: _colorScheme.primary,
    ),
    canvasColor: _colorScheme.background,
    toggleableActiveColor: _colorScheme.primary,
    highlightColor: Colors.transparent,
    indicatorColor: _colorScheme.onPrimary,
    primaryColor: _colorScheme.primary,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: _colorScheme.background,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    typography: Typography.material2018(
      platform: defaultTargetPlatform,
    ),
  );

  static const _colorScheme = ColorScheme(
    primary: Color(0xFF6200EE),
    primaryVariant: Color(0xFF6200EE),
    secondary: Color(0xFFFF5722),
    secondaryVariant: Color(0xFFFF5722),
    background: Colors.white,
    surface: Color(0xFFF2F2F2),
    onBackground: Colors.black,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    brightness: Brightness.light,
  );
}
