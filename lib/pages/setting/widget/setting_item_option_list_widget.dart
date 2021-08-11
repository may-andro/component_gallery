import 'package:component_gallery/pages/setting/model/setting_item.dart';
import 'package:flutter/material.dart';

class SettingItemOptionListWidget<T> extends StatelessWidget {
  SettingItemOptionListWidget({
    Key? key,
    required this.settingItem,
    required this.onOptionChanged,
  }) : super(key: key);

  final SettingItem<T> settingItem;
  final Function(T) onOptionChanged;

  @override
  Widget build(BuildContext context) {
    final _options = settingItem.optionsMap.keys;
    final _displayOptions = settingItem.optionsMap.values;
    final theme = Theme.of(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: settingItem.isExpanded ? _options.length : 0,
      itemBuilder: (context, index) {
        final displayOption = _displayOptions.elementAt(index);
        return RadioListTile<T>(
          value: _options.elementAt(index),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayOption.title,
                style: theme.textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              if (displayOption.subtitle != null)
                Text(
                  displayOption.subtitle!,
                  style: theme.textTheme.bodyText1?.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
            ],
          ),
          groupValue: settingItem.selectedOption,
          onChanged: (newOption) {
            if (newOption != null) onOptionChanged(newOption);
          },
          activeColor: Theme.of(context).colorScheme.primary,
          dense: true,
        );
      },
    );
  }
}
