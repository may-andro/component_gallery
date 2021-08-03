import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
	return HomeStateNotifier();
});