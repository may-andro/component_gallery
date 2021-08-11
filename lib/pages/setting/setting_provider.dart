import 'dart:collection';

import 'package:component_gallery/pages/setting/setting_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:component/theme/app_theme_provider.dart';

import 'model/setting_item.dart';
import 'package:component/theme/utils/enums/design_system.dart';

final settingStateProvider = StateNotifierProvider<SettingStateNotifier, SettingState>((ref) {
  final appThemeState = ref.read(appThemeStateProvider);
  final appThemeStateNotifier = ref.read(appThemeStateProvider.notifier);

  final settingList = [
    SettingItem<TargetPlatform>(
      settingType: ExpandableSetting.platform,
      title: 'TargetPlatform',
      description: '${appThemeState.getTargetPlatform()}',
      optionsMap: LinkedHashMap.of({
        TargetPlatform.android: DisplayOption('Android'),
        TargetPlatform.iOS: DisplayOption('iOS'),
      }),
      selectedOption: appThemeState.getTargetPlatform(),
      onOptionChanged: (targetPlatform) {
        print('targetPlatform');
        appThemeStateNotifier.setTargetPlatform(targetPlatform);
      },
    ),
    SettingItem<DesignSystem>(
      settingType: ExpandableSetting.theme,
      title: 'Theme',
      description: '${appThemeState.getDesignSystem()}',
      optionsMap: LinkedHashMap.of({
        DesignSystem.ocean_blue: DisplayOption('Ocean Blue'),
        DesignSystem.twilight_red: DisplayOption('Twilight Red'),
      }),
      selectedOption: appThemeState.getDesignSystem(),
      onOptionChanged: (designSystem) {
        appThemeStateNotifier.setDesignSystem(designSystem);
      },
    )
  ];

  return SettingStateNotifier(settingList);
});
