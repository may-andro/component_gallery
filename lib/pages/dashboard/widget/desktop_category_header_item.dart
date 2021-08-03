import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/pages/dashboard/widget/category_Item.dart';
import 'package:component_gallery/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';

class DesktopCategoryItem extends StatelessWidget {
  const DesktopCategoryItem({
    required this.category,
    this.asset,
    required this.components,
  });

  final ComponentCategory category;
  final ImageProvider? asset;
  final List<Component> components;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DesktopCategoryHeader(
            category: category,
            asset: asset,
          ),
          Divider(
            height: 2,
            thickness: 2,
            color: colorScheme.background,
          ),
          Flexible(
            child: ListView.builder(
              // Makes integration tests possible.
              key: ValueKey('${category.name}DemoList'),
              shrinkWrap: true,
              itemBuilder: (context, index) => CategoryDemoItem(component: components[index]),
              itemCount: components.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopCategoryHeader extends StatelessWidget {
  const _DesktopCategoryHeader({
    required this.category,
    this.asset,
  });

  final ComponentCategory category;
  final ImageProvider? asset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      // Makes integration tests possible.
      key: ValueKey('${category.name}CategoryHeader'),
      color: colorScheme.onBackground,
      child: Row(
        children: [
          Padding(
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
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: Text(
                category.displayTitle(),
                style: Theme.of(context).textTheme.headline5?.apply(
                      color: colorScheme.onSurface,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
