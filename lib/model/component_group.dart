import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_category.dart';
import 'package:flutter/material.dart';

class ComponentGroup {
  const ComponentGroup({
    required this.title,
    required this.category,
    required this.icon,
    required this.components,
  });

  final String title;
  final ComponentCategory category;
  final IconData icon;
  final List<Component> components;
}
