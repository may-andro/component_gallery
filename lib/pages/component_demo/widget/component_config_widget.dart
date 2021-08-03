import 'package:component_gallery/model/component_configuration.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:component_gallery/utils/constants.dart';
import 'package:flutter/material.dart';

class ComponentConfigWidget extends StatelessWidget {
  const ComponentConfigWidget({
    Key? key,
    required this.configurations,
    required this.configIndex,
    required this.onConfigChanged,
    required this.maxHeight,
    required this.maxWidth,
  }) : super(key: key);

  final List<ComponentConfiguration> configurations;
  final int configIndex;
  final ValueChanged<int> onConfigChanged;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 24,
                top: 12,
                end: 24,
              ),
              child: Text(
                'Options',
                style: textTheme.headline4?.apply(
                  color: colorScheme.onSurface,
                  fontSizeDelta: isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 16,
              color: colorScheme.onSurface,
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final configuration in configurations)
                    _ConfigOptionsItem(
                      title: configuration.title,
                      isSelected: configuration == configurations[configIndex],
                      onTap: () {
                        onConfigChanged(configurations.indexOf(configuration));
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _ConfigOptionsItem extends StatelessWidget {
  const _ConfigOptionsItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: isSelected ? colorScheme.surface : null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText2?.apply(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
