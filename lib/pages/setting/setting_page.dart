import 'package:component_gallery/pages/dashboard/widget/header.dart';
import 'package:component_gallery/pages/setting/setting_provider.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:component_gallery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:component/theme/app_theme_provider.dart';
import 'model/setting_item.dart';
import 'widget/setting_item_option_list_widget.dart';

import 'package:component/theme/utils/enums/design_system.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);

    return Consumer(builder: (context, watch, child) {
      watch(settingStateProvider);

      return Material(
        color: colorScheme.secondaryVariant,
        child: Padding(
          padding: isDesktop
              ? EdgeInsets.zero
              : const EdgeInsets.only(
                  bottom: galleryHeaderHeight,
                ),
          child: MediaQuery.removePadding(
            removeTop: isDesktop,
            context: context,
            child: ListView(
              children: [
                _buildTopPadding(isDesktop),
                _buildHeader(context),
                _buildExpandableSettingList(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTopPadding(bool isDesktop) {
    return isDesktop ? const SizedBox(height: firstHeaderDesktopTopPadding) : SizedBox.shrink();
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ExcludeSemantics(
        child: Header(
          color: Theme.of(context).colorScheme.onSurface,
          text: 'Setting',
        ),
      ),
    );
  }

  _buildExpandableSettingList(BuildContext context) {
    final settingStateNotifier = context.read(settingStateProvider.notifier);
    final settingState = context.read(settingStateProvider);

    return SingleChildScrollView(
      child: ExpansionPanelList(
        animationDuration: const Duration(milliseconds: 300),
        expandedHeaderPadding: EdgeInsets.all(10),
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          settingStateNotifier.updateSettingItem(index, !isExpanded);
        },
        children: settingState.getSettingList().map((item) => _buildExpansionPanel(item, context)).toList(),
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(SettingItem item, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settingStateNotifier = context.read(settingStateProvider.notifier);

    return ExpansionPanel(
      isExpanded: item.isExpanded,
      canTapOnHeader: true,
      backgroundColor: colorScheme.secondaryVariant,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.description),
        );
      },
      body: SettingItemOptionListWidget(
        settingItem: item,
        onOptionChanged: (T) {
          print('SettingPage._buildExpansionPanel T $T ${item.settingType}');
          //item.onOptionChanged(T);
          handleThemeUpdate(context, item.settingType, T);

          settingStateNotifier.updateSettingItemOptions(item, T);
        },
      ),
    );
  }

  void handleThemeUpdate(BuildContext context, ExpandableSetting expandableSetting, dynamic option) {
    final appThemeStateNotifier = context.read(appThemeStateProvider.notifier);

    switch (expandableSetting) {
      case ExpandableSetting.platform:
        {
          appThemeStateNotifier.setTargetPlatform(option as TargetPlatform);
          break;
        }
      case ExpandableSetting.theme:
        {
          appThemeStateNotifier.setDesignSystem(option as DesignSystem);
          break;
        }
    }
  }
}
