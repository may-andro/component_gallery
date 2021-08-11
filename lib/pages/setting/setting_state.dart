import 'package:component_gallery/pages/setting/model/setting_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingState {
  SettingState(this._settingList);

  final List<SettingItem> _settingList;

  SettingState copy({
    List<SettingItem>? settingList,
  }) {
    return SettingState(
      settingList ?? this._settingList,
    );
  }

  List<SettingItem> getSettingList() {
    return _settingList;
  }
}

class SettingStateNotifier extends StateNotifier<SettingState> {
  SettingStateNotifier(List<SettingItem> list) : super(SettingState(list));

  void updateSettingItem(int index, bool isExpanded) {
    final settingList = state.getSettingList();
    settingList[index].isExpanded = isExpanded;
    state = state.copy(
      settingList: settingList,
    );
  }

  void updateSettingItemOptions<T>(SettingItem item, T option) {
    final settingList = state.getSettingList();
    final index = settingList.indexOf(item);
    settingList[index].selectedOption = option;
    state = state.copy(
      settingList: settingList,
    );
  }

  void setSettingList(List<SettingItem> settingList) {
    state = state.copy(
      settingList: settingList,
    );
  }
}
