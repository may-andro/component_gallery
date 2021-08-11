import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component_gallery_options.dart';

class AppGlobalState {
  AppGlobalState(this._componentGalleryOptions);

  final ComponentGalleryOptions _componentGalleryOptions;

  factory AppGlobalState.initial() {
    return AppGlobalState(
      ComponentGalleryOptions(
        themeMode: ThemeMode.system,
        platform: TargetPlatform.android,
      ),
    );
  }

  AppGlobalState copy({
    ComponentGalleryOptions? newComponentGalleryOptions,
  }) {
    return AppGlobalState(
      newComponentGalleryOptions ?? this._componentGalleryOptions,
    );
  }

  ComponentGalleryOptions getComponentGalleryOptions() {
    return _componentGalleryOptions;
  }
}

class AppGlobalStateNotifier extends StateNotifier<AppGlobalState> {
  AppGlobalStateNotifier() : super(AppGlobalState.initial());

  void setComponentGalleryOptions(ComponentGalleryOptions newComponentGalleryOptions) {
    state = state.copy(newComponentGalleryOptions: newComponentGalleryOptions);
  }

  void setTheme(ThemeMode themeMode) {
    state = state.copy(
      newComponentGalleryOptions: state._componentGalleryOptions.copyWith(
        themeMode: themeMode,
      ),
    );
  }

  void setTargetPlatform(TargetPlatform platform) {
    state = state.copy(
      newComponentGalleryOptions: state._componentGalleryOptions.copyWith(
        platform: platform,
      ),
    );
  }
}
