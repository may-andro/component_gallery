import 'package:component_gallery/app/app_provider.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:component_gallery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = isDisplayDesktop(context);

    return Consumer(builder: (context, watch, child) {
      final appState = context.read(appStateProvider);
      final componentGalleryOptions = appState.getComponentGalleryOptions();

      return Material(
        color: colorScheme.secondaryVariant,
        child: Padding(
          padding: isDesktop
              ? EdgeInsets.zero
              : const EdgeInsets.only(
                  bottom: galleryHeaderHeight,
                ),
          child: MediaQuery.removePadding(
            removeTop: isDesktop,
            context: context,
            child: Container(),
          ),
        ),
      );
    });
  }
}
