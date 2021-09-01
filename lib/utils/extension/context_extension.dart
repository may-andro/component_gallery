import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:component_gallery/utils/responsive/device_resolution.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

  Brightness get brightness => MediaQuery.of(this).platformBrightness;

  DeviceResolution get deviceResolution {
    switch (getWindowType(this)) {
      case AdaptiveWindowType.xsmall:
        return DeviceResolution.mobile;
      case AdaptiveWindowType.small:
        return DeviceResolution.tablet;
      case AdaptiveWindowType.medium:
        return DeviceResolution.desktop;
      case AdaptiveWindowType.large:
        return DeviceResolution.desktop;
      case AdaptiveWindowType.xlarge:
        return DeviceResolution.desktop;
      default:
        return DeviceResolution.desktop;
    }
  }
}
