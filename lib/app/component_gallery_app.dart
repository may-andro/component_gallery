import 'package:component_gallery/pages/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'gallery_theme_data.dart';

class ComponentGalleryApp extends StatelessWidget {
  const ComponentGalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final _appState = context.read(appStateProvider);
      return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
        restorationScopeId: 'rootGallery',
        title: 'Component Gallery',
        debugShowCheckedModeBanner: false,
        themeMode: _appState.getComponentGalleryOptions().themeMode,
        theme: GalleryThemeData.lightThemeData.copyWith(
          platform: _appState.getComponentGalleryOptions().platform,
        ),
        darkTheme: GalleryThemeData.darkThemeData.copyWith(
          platform: _appState.getComponentGalleryOptions().platform,
        ),
        home: HomePage(),
      );
    });
  }
}
