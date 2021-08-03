import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComponentGalleryOptions {
  const ComponentGalleryOptions({
    required this.themeMode,
    required this.platform,
  });

  final ThemeMode themeMode;
  final TargetPlatform platform;

  ComponentGalleryOptions copyWith({
    ThemeMode? themeMode,
    TargetPlatform? platform,
  }) {
    return ComponentGalleryOptions(
      themeMode: themeMode ?? this.themeMode,
      platform: platform ?? this.platform,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ComponentGalleryOptions && themeMode == other.themeMode && platform == other.platform;

  @override
  int get hashCode => hashValues(
        themeMode,
        platform,
      );
}
