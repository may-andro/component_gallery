import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme_state.dart';

final appThemeStateProvider = StateNotifierProvider<AppThemeStateNotifier, AppThemeState>((ref) {
  return AppThemeStateNotifier();
});
