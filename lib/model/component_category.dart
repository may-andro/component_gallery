import 'package:flutter/foundation.dart' show describeEnum;

enum ComponentCategory {
	button,
	text,
	list,
}


extension ComponentCategoryExtension on ComponentCategory {
	String get name => describeEnum(this);

	String displayTitle() {
		switch (this) {
			case ComponentCategory.button:
				return 'Button';
			case ComponentCategory.text:
				return 'Text';
			case ComponentCategory.list:
				return 'List';
			default: return 'Unknown';
		}
	}
}