import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  HomeState(this._isSettingsOpen);

  final bool _isSettingsOpen;

  factory HomeState.initial() {
    return HomeState(
      false,
    );
  }

  HomeState copy({
    bool? isSettingsOpen,
  }) {
    return HomeState(
      isSettingsOpen ?? this._isSettingsOpen,
    );
  }

  bool isSettingsOpen() {
    return _isSettingsOpen;
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
	HomeStateNotifier() : super(HomeState.initial());

	void setIsSettingsOpen(bool isSettingsOpen) {
		state = state.copy(
			isSettingsOpen: isSettingsOpen,
		);
	}
}

