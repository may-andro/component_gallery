import 'dart:collection';

import 'package:component_gallery/pages/setting/model/setting_item.dart';
import 'package:flutter/material.dart';



class SettingItemWidget<T> extends StatelessWidget {
  const SettingItemWidget({
    Key? key,
    required this.optionsMap,
    required this.title,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.onTapSetting,
    required this.isExpanded,
  }) : super(key: key);

  final LinkedHashMap<T, DisplayOption> optionsMap;
  final String title;
  final T selectedOption;
  final Function(T) onOptionChanged;
  final Function onTapSetting;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
