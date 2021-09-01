import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:flutter/material.dart';

class ComponentListPage extends StatelessWidget {
  const ComponentListPage({
    Key? key,
    required this.componentGroup,
    required this.onListItemClick,
  }) : super(key: key);

  final ComponentGroup componentGroup;
  final Function(Component)? onListItemClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _ComponentItemWidget(
          component: componentGroup.components[index],
          onItemClick: onListItemClick,
        );
      },
      itemCount: componentGroup.components.length,
    );
  }
}

class _ComponentItemWidget extends StatelessWidget {
  const _ComponentItemWidget({
    Key? key,
    required this.component,
    required this.onItemClick,
  }) : super(key: key);

  final Component component;
  final Function(Component)? onItemClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: onItemClick != null ? () => onItemClick!(component) : null,
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
          component.title,
          style: textTheme.subtitle1?.apply(color: colorScheme.onSurface),
        ),
        Text(
          component.subtitle,
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
      component.icon,
      color: colorScheme.primary,
    );
  }
}
