import 'package:component_gallery/component/button/primary_button/config_inactive.dart';
import 'package:component_gallery/component/button/primary_button/config_large.dart';
import 'package:component_gallery/component/button/primary_button/config_loading.dart';
import 'package:component_gallery/component/button/primary_button/config_normal.dart';
import 'package:component_gallery/component/button/prominent_button/config_active.dart';
import 'package:component_gallery/component/button/prominent_button/config_inactive.dart';
import 'package:component_gallery/component/button/prominent_button/config_loading.dart';
import 'package:component_gallery/component/button/secondary_button/component_secondary_button.dart';
import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/model/component_configuration.dart';
import 'package:flutter/material.dart';

List<Component> buttonComponent() {
  return [
    Component(
      title: 'Prominent Button',
      icon: Icons.view_list_outlined,
      subtitle: 'Used only during the shopping process to be used only one time per screen',
      configurations: [
        ComponentConfiguration(
          title: 'Prominent Button',
          description: 'This configuration is used when state is enabled',
          widgetPath: 'lib/component/button/prominent_button/config_active.dart',
          widget: ConfigActiveProminentButton(),
        ),
        ComponentConfiguration(
          title: 'Loading Prominent Button',
          description: 'This configuration is used when state is loading',
          widgetPath: 'lib/component/button/prominent_button/config_loading.dart',
          widget: ConfigLoadingProminentButton(),
        ),
        ComponentConfiguration(
          title: 'Disabled Prominent Button',
          description: 'This configuration is used when state is disabled',
          widgetPath: 'lib/component/button/prominent_button/config_inactive.dart',
          widget: ConfigInActiveProminentButton(),
        ),
      ],
      category: ComponentCategory.button,
    ),
    Component(
      title: 'Primary Button',
      icon: Icons.view_list_outlined,
      subtitle: 'Used only one time per screen',
      configurations: [
        ComponentConfiguration(
          title: 'Active Primary Button',
          description: 'Used only one time per screen',
          widgetPath: 'lib/component/button/primary_button/config_normal.dart',
          widget: ConfigActivePrimaryButton(),
        ),
        ComponentConfiguration(
          title: 'Large Primary Button',
          description: 'Used only one time per screen when state is loading',
          widgetPath: 'lib/component/button/primary_button/config_large.dart',
          widget: ConfigLargePrimaryButton(),
        ),
        ComponentConfiguration(
          title: 'Loading Primary Button',
          description: 'Used only one time per screen when state is disabled',
          widgetPath: 'lib/component/button/primary_button/config_loading.dart',
          widget: ConfigLoadingPrimaryButton(),
        ),
        ComponentConfiguration(
          title: 'InActive Primary Button',
          description: 'Used only one time per screen when state is disabled',
          widgetPath: 'lib/component/button/primary_button/config_inactive.dart',
          widget: ConfigInActivePrimaryButton(),
        ),
      ],
      category: ComponentCategory.button,
    ),
    Component(
      title: 'Secondary Button',
      icon: Icons.view_list_outlined,
      subtitle: 'Only for secondary actions which can be used multiple times',
      configurations: [
        ComponentConfiguration(
          title: 'Secondary Button',
          description: 'This configuration is used when state is enabled',
          widgetPath: 'lib/component/button/secondary_button/component_secondary_button.dart',
          widget: ComponentSecondaryButton.normal(),
        ),
        ComponentConfiguration(
          title: 'Loading Secondary Button',
          description: 'This configuration is used when state is loading',
          widgetPath: 'lib/component/button/secondary_button/component_secondary_button.dart',
          widget: ComponentSecondaryButton.loading(),
        ),
      ],
      category: ComponentCategory.button,
    ),
  ];
}
