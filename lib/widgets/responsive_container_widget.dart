import 'package:component_gallery/utils/responsive/device_resolution.dart';
import 'package:flutter/material.dart';
import 'package:component_gallery/utils/extension/context_extension.dart';

class ResponsiveContainerWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveContainerWidget({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (context.deviceResolution) {
          case DeviceResolution.mobile:
            return mobile;
          case DeviceResolution.tablet:
            return tablet;
          case DeviceResolution.desktop:
            return desktop;
          default:
            throw UnimplementedError();
        }
      },
    );
  }
}
