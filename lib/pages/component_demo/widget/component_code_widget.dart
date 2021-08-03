import 'package:component_gallery/app/gallery_theme_data.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:flutter/material.dart';

class ComponentCodeWidget extends StatelessWidget {
  const ComponentCodeWidget({
    Key? key,
    required this.maxHeight,
    required this.codeWidget,
  }) : super(key: key);

  final double maxHeight;
  final Widget codeWidget;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return Theme(
      data: GalleryThemeData.darkThemeData,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          color: isDesktop ? null : GalleryThemeData.darkThemeData.canvasColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: maxHeight,
          child: codeWidget,
        ),
      ),
    );
  }
}
