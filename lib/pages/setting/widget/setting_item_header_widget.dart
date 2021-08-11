import 'package:flutter/material.dart';

class SettingItemHeaderWidget extends StatelessWidget {
  const SettingItemHeaderWidget({
    Key? key,
    required this.margin,
    required this.padding,
    required this.borderRadius,
    required this.subtitleHeight,
    required this.chevronRotation,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final String title;
  final String subtitle;
  final Animation<double> subtitleHeight;
  final Animation<double> chevronRotation;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: margin,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: colorScheme.secondary,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.subtitle1?.apply(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: subtitleHeight,
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.overline?.apply(
                            color: colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 24,
                ),
                child: RotationTransition(
                  turns: chevronRotation,
                  child: const Icon(Icons.arrow_drop_down),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
