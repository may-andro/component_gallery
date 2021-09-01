import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_category.dart';
import 'package:flutter/material.dart';

class ComponentGroup {
  const ComponentGroup({
    required this.title,
    required this.category,
    required this.components,
    required this.componentPreviewWidget,
    this.icon,
  });

  final String title;
  final ComponentCategory category;
  final IconData? icon;
  final List<Component> components;
  final Widget componentPreviewWidget;
}
