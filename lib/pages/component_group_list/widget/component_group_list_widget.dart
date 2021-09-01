import 'package:component_gallery/model/component_group.dart';
import 'package:flutter/material.dart';

class ComponentGroupListWidget extends StatelessWidget {
  const ComponentGroupListWidget({
    Key? key,
    required this.componentGroupList,
    required this.onListItemClick,
  }) : super(key: key);

  final List<ComponentGroup> componentGroupList;
  final Function(ComponentGroup)? onListItemClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final componentGroup = componentGroupList[index];
        return _ComponentGroupItemWidget(
          componentGroup: componentGroup,
          onListItemClick: onListItemClick,
        );
      },
      itemCount: componentGroupList.length,
    );
  }
}

class _ComponentGroupItemWidget extends StatelessWidget {
  const _ComponentGroupItemWidget({
    required this.componentGroup,
    required this.onListItemClick,
  });

  final ComponentGroup componentGroup;
  final Function(ComponentGroup)? onListItemClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: onListItemClick != null ? () => onListItemClick!(componentGroup) : null,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16,
            top: 8,
            end: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconWidget(context),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: _buildComponentDetailWidget(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComponentDetailWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          componentGroup.title,
          style: textTheme.subtitle1?.apply(color: colorScheme.onSurface),
        ),
        Text(
          'Think if we need description here',
          style: textTheme.overline?.apply(
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 20),
        Divider(
          thickness: 1,
          height: 1,
          color: Theme.of(context).colorScheme.background,
        ),
      ],
    );
  }

  Widget _buildIconWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Icon(
      componentGroup.icon,
      color: colorScheme.primary,
    );
  }
}
