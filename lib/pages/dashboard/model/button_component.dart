import 'package:component_gallery/component/button/primary_button/component_primary_button.dart';
import 'package:component_gallery/component/button/prominent_button/component_prominent_button.dart';
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
          widgetPath: 'lib/component/button/prominent_button/component_prominent_button.dart',
          widget: ComponentProminentButton.normal(),
        ),
        ComponentConfiguration(
          title: 'Loading Prominent Button',
          description: 'This configuration is used when state is loading',
          widgetPath: 'lib/component/button/prominent_button/component_prominent_button.dart',
          widget: ComponentProminentButton.loading(),
        ),
        ComponentConfiguration(
          title: 'Disabled Prominent Button',
          description: 'This configuration is used when state is disabled',
          widgetPath: 'lib/component/button/prominent_button/component_prominent_button.dart',
          widget: ComponentProminentButton.disabled(),
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
          title: 'Primary Button',
          description: 'Used only one time per screen',
          widgetPath: 'lib/component/button/prominent_button/component_primary_button.dart',
          widget: ComponentPrimaryButton.normal(),
        ),
        ComponentConfiguration(
          title: 'Loading Primary Button',
          description: 'Used only one time per screen when state is loading',
          widgetPath: 'lib/component/button/prominent_button/component_primary_button.dart',
          widget: ComponentPrimaryButton.loading(),
        ),
        ComponentConfiguration(
          title: 'Disabled Primary Button',
          description: 'Used only one time per screen when state is disabled',
          widgetPath: 'lib/component/button/prominent_button/component_primary_button.dart',
          widget: ComponentPrimaryButton.disabled(),
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
