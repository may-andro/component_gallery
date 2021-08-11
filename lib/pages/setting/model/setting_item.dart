import 'dart:collection';

enum ExpandableSetting {
  platform,
  theme,
}

class DisplayOption {
  final String title;
  final String? subtitle;

  DisplayOption(
    this.title, {
    this.subtitle,
  });
}

class SettingItem<T> {
  SettingItem({
    required this.settingType,
    required this.title,
    required this.description,
    this.isExpanded = false,
    required this.optionsMap,
    required this.selectedOption,
    required this.onOptionChanged,
  });

  final ExpandableSetting settingType;
  final String title;
  final String description;
  bool isExpanded;
  final LinkedHashMap<T, DisplayOption> optionsMap;
  T selectedOption;
  final Function(T) onOptionChanged;
}
