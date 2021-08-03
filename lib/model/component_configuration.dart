import 'package:flutter/material.dart';

typedef CodeDisplayer = TextSpan Function(BuildContext context);

class ComponentConfiguration {
  const ComponentConfiguration({
    required this.title,
    required this.description,
    required this.widget,
    required this.widgetPath,
  });

  final String title;
  final String description;
  final Widget widget;
  final String widgetPath;
}
