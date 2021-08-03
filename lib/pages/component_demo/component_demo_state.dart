import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DemoState {
  options,
  info,
  code,
}

class ComponentDemoState {
  ComponentDemoState(this._configIndex, this._demoState);

  final int _configIndex;
  final DemoState _demoState;

  factory ComponentDemoState.initial() {
    return ComponentDemoState(
      0,
      DemoState.info,
    );
  }

  ComponentDemoState copy({
    int? configIndex,
    DemoState? demoState,
  }) {
    return ComponentDemoState(
      configIndex ?? this._configIndex,
      demoState ?? this._demoState,
    );
  }

  int getSelectedConfigIndex() {
    return _configIndex;
  }

  DemoState getSelectedDemoState() {
    return _demoState;
  }
}

class ComponentDemoStateNotifier extends StateNotifier<ComponentDemoState> {
  ComponentDemoStateNotifier() : super(ComponentDemoState.initial());

  void setSelectedConfigIndex(int configIndex) {
    state = state.copy(
      configIndex: configIndex,
    );
  }

  void setSelectedDemoState(DemoState demoState) {
    state = state.copy(
      demoState: demoState,
    );
  }
}
