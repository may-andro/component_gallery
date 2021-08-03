import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component_demo_state.dart';

final componentDemoStateProvider = StateNotifierProvider.autoDispose<ComponentDemoStateNotifier, ComponentDemoState>((ref) {
  return ComponentDemoStateNotifier();
});
