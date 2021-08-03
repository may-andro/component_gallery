import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state.dart';

final appStateProvider = StateNotifierProvider<AppGlobalStateNotifier, AppGlobalState>((ref) {
	return AppGlobalStateNotifier();
});