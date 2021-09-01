import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/pages/component_list/component_list_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class _WidgetState {
  ComponentGroup? _selectedComponentGroup;

  final _selectedComponentGroupSubject = PublishSubject<ComponentGroup?>();

  Stream<ComponentGroup?> get selectedComponentGroupStream => _selectedComponentGroupSubject.stream;

  Sink<ComponentGroup?> get _selectedComponentGroupSink => _selectedComponentGroupSubject.sink;

  setSelectedComponentGroup(ComponentGroup componentGroup) {
    if (componentGroup.category != _selectedComponentGroup?.category) {
      _selectedComponentGroup = componentGroup;
      _selectedComponentGroupSink.add(componentGroup);
    } else {
      _selectedComponentGroup = null;
      _selectedComponentGroupSink.add(null);
    }
  }

  bool isExpended(ComponentGroup componentGroup) {
    return componentGroup.category == _selectedComponentGroup?.category;
  }

  dispose() {
    _selectedComponentGroupSubject.close();
  }
}

class ComponentGroupExpendableListWidget extends StatefulWidget {
  ComponentGroupExpendableListWidget({
    Key? key,
    required this.componentGroupList,
    required this.onComponentClick,
    required this.onComponentGroupClick,
  }) : super(key: key);

  final List<ComponentGroup> componentGroupList;
  final Function(Component)? onComponentClick;
  final Function(ComponentGroup)? onComponentGroupClick;

  @override
  _ComponentGroupExpendableListWidgetState createState() => _ComponentGroupExpendableListWidgetState();
}

class _ComponentGroupExpendableListWidgetState extends State<ComponentGroupExpendableListWidget> {
  late _WidgetState _widgetState;

  @override
  void initState() {
    _widgetState = _WidgetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<ComponentGroup?>(
          stream: _widgetState.selectedComponentGroupStream,
          builder: (context, snapshot) {
            return ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 300),
              expandedHeaderPadding: EdgeInsets.all(10),
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) {
                final componentGroup = widget.componentGroupList[index];
                _widgetState.setSelectedComponentGroup(componentGroup);
                widget.onComponentGroupClick?.call(componentGroup);
              },
              children: widget.componentGroupList.map((item) => _buildExpansionPanel(item, context)).toList(),
            );
          }),
    );
  }

  ExpansionPanel _buildExpansionPanel(ComponentGroup componentGroup, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionPanel(
      isExpanded: _widgetState.isExpended(componentGroup),
      canTapOnHeader: true,
      backgroundColor: _widgetState.isExpended(componentGroup) ? colorScheme.onBackground : colorScheme.surface,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return _ComponentGroupHeader(componentGroup: componentGroup);
      },
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ComponentListPage(
          componentGroup: componentGroup,
          onListItemClick: widget.onComponentClick,
        ),
      ),
    );
  }
}

class _ComponentGroupHeader extends StatelessWidget {
  const _ComponentGroupHeader({required this.componentGroup});

  final ComponentGroup componentGroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComponentGroupIconWidget(),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: _buildComponentGroupTitleWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentGroupIconWidget() {
    return componentGroup.icon != null ? Icon(componentGroup.icon) : Icon(Icons.category);
  }

  Widget _buildComponentGroupTitleWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          componentGroup.title,
          style: textTheme.headline5?.apply(color: colorScheme.onSurface),
        ),
        Text(
          'Check if the description is needed.',
          style: textTheme.overline?.apply(
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
