
enum ComponentCategory {
	button,
	text,
	list,
}


extension ComponentCategoryExtension on ComponentCategory {
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