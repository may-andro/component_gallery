
import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/model/component_configuration.dart';
import 'package:flutter/material.dart';

class Component {
	const Component({
		required this.title,
		required this.subtitle,
		required this.category,
		required this.icon,
		required this.configurations,
	});

	final String title;
	final String subtitle;
	final ComponentCategory category;
	final IconData icon;
	final List<ComponentConfiguration> configurations;
}