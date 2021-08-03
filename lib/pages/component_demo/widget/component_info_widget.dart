import 'package:component_gallery/utils/adaptive.dart';
import 'package:component_gallery/utils/constants.dart';
import 'package:flutter/material.dart';

class ComponentInfoWidget extends StatelessWidget {
  const ComponentInfoWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.maxHeight,
    required this.maxWidth,
  }) : super(key: key);
  final double maxHeight;
  final double maxWidth;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 24,
          top: 12,
          end: 24,
          bottom: 32,
        ),
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: textTheme.headline4?.apply(
                  color: colorScheme.onSurface,
                  fontSizeDelta: isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: textTheme.bodyText2?.apply(color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
