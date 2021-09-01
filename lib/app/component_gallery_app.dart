import 'package:component_gallery/pages/dashboard/dashboard_page.dart';
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
      final appState = context.read(appStateProvider);

      return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
        restorationScopeId: 'rootGallery',
        title: 'Component Gallery',
        debugShowCheckedModeBanner: false,
        themeMode: appState.getComponentGalleryOptions().themeMode,
        theme: GalleryThemeData.lightThemeData.copyWith(
          platform: appState.getComponentGalleryOptions().platform,
        ),
        darkTheme: GalleryThemeData.darkThemeData.copyWith(
          platform: appState.getComponentGalleryOptions().platform,
        ),
        home: DashboardPage(),
      );
    });
  }
}
