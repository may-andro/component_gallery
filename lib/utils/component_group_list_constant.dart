import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/pages/dashboard/model/button_component.dart';

final List<ComponentGroup> componentGroupList = [
  ComponentGroup(
    title: ComponentCategory.button.displayTitle(),
    category: ComponentCategory.button,
    components: buttonComponent(),
    componentPreviewWidget: getButtonComponentPreview(),
  ),
  ComponentGroup(
    title: ComponentCategory.text.displayTitle(),
    category: ComponentCategory.text,
    components: buttonComponent(),
    componentPreviewWidget: getButtonComponentPreview(),
  ),
  ComponentGroup(
    title: ComponentCategory.list.displayTitle(),
    category: ComponentCategory.list,
    components: buttonComponent(),
    componentPreviewWidget: getButtonComponentPreview(),
  ),
];
