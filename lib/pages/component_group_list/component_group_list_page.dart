import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/pages/component_group_list/widget/component_group_expandable_list_widget.dart';
import 'package:component_gallery/pages/component_group_list/widget/component_group_list_widget.dart';
import 'package:component_gallery/pages/component_group_list/widget/component_group_staggered_list_widget.dart';
import 'package:flutter/material.dart';

enum _ComponentGroupListType { list, expandableList, staggeredList }

class ComponentGroupListPage extends StatelessWidget {
  const ComponentGroupListPage.list({
    Key? key,
    required this.componentGroupList,
    required this.onComponentGroupClick,
  })  : _componentGroupListType = _ComponentGroupListType.list,
        onComponentClick = null,
        super(key: key);

  const ComponentGroupListPage.expandableList({
    Key? key,
    required this.componentGroupList,
    required this.onComponentClick,
    required this.onComponentGroupClick,
  })  : _componentGroupListType = _ComponentGroupListType.expandableList,
        super(key: key);

  const ComponentGroupListPage.staggeredList({
    Key? key,
    required this.componentGroupList,
    required this.onComponentClick,
  })  : _componentGroupListType = _ComponentGroupListType.staggeredList,
        onComponentGroupClick = null,
        super(key: key);

  final _ComponentGroupListType _componentGroupListType;
  final List<ComponentGroup> componentGroupList;
  final Function(ComponentGroup)? onComponentGroupClick;
  final Function(Component)? onComponentClick;

  @override
  Widget build(BuildContext context) {
    return _buildComponentGroupList();
  }

  Widget _buildComponentGroupList() {
    switch (_componentGroupListType) {
      case _ComponentGroupListType.list:
        return ComponentGroupListWidget(
          componentGroupList: componentGroupList,
          onListItemClick: onComponentGroupClick,
        );
      case _ComponentGroupListType.expandableList:
        return ComponentGroupExpendableListWidget(
          componentGroupList: componentGroupList,
          onComponentClick: onComponentClick,
          onComponentGroupClick: onComponentGroupClick,
        );
      case _ComponentGroupListType.staggeredList:
        return ComponentGroupStaggeredListWidget(
          componentGroupList: componentGroupList,
          onComponentClick: onComponentClick,
        );
    }
  }
}
