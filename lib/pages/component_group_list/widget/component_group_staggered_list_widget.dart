import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/pages/component_list/component_list_page.dart';
import 'package:component_gallery/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const _axisSpacing = 16.0;
const _crossAxisCount = 2;
const _borderRadius = 10.0;
const _dividerHeight = 2.0;
const _dividerThickness = 2.0;
const _screenPadding = 20.0;

class ComponentGroupStaggeredListWidget extends StatelessWidget {
  const ComponentGroupStaggeredListWidget({
    Key? key,
    required this.componentGroupList,
    required this.onComponentClick,
    this.crossAxisCount = _crossAxisCount,
  }) : super(key: key);

  final List<ComponentGroup> componentGroupList;
  final Function(Component)? onComponentClick;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _screenPadding),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: _axisSpacing,
        mainAxisSpacing: _axisSpacing,
        itemCount: componentGroupList.length,
        staggeredTileBuilder: (index) => index == 0 ? StaggeredTile.fit(crossAxisCount) : const StaggeredTile.fit(1),
        itemBuilder: (BuildContext ctx, index) {
          final componentGroup = componentGroupList[index];
          return _ComponentGroupItemWidget(
            componentGroup: componentGroup,
            onComponentClick: onComponentClick,
          );
        },
      ),
    );
  }
}

class _ComponentGroupItemWidget extends StatelessWidget {
  const _ComponentGroupItemWidget({
    required this.componentGroup,
    required this.onComponentClick,
  });

  final ComponentGroup componentGroup;
  final Function(Component)? onComponentClick;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(_borderRadius),
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ComponentGroupHeader(category: componentGroup.category),
          Divider(
            height: _dividerHeight,
            thickness: _dividerThickness,
            color: colorScheme.background,
          ),
          Flexible(
            child: ComponentListPage(
              componentGroup: componentGroup,
              onListItemClick: onComponentClick,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComponentGroupHeader extends StatelessWidget {
  const _ComponentGroupHeader({
    required this.category,
    this.asset,
  });

  final ComponentCategory category;
  final ImageProvider? asset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.onBackground,
      child: Row(
        children: [
          _buildComponentGroupIconWidget(),
          Flexible(
            child: _buildComponentGroupTitleWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentGroupIconWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: asset != null
          ? FadeInImagePlaceholder(
              image: asset!,
              placeholder: const SizedBox(
                height: 64,
                width: 64,
              ),
              width: 64,
              height: 64,
              excludeFromSemantics: true,
            )
          : Icon(Icons.category),
    );
  }

  Widget _buildComponentGroupTitleWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Text(
        category.displayTitle(),
        style: Theme.of(context).textTheme.headline5?.apply(
              color: colorScheme.onSurface,
            ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
