import 'package:component_gallery/model/component_category.dart';
import 'package:component_gallery/model/component_group.dart';
import 'package:component_gallery/pages/dashboard/model/button_component.dart';
import 'package:component_gallery/pages/dashboard/widget/desktop_category_header_item.dart';
import 'package:component_gallery/pages/dashboard/widget/header.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const _horizontalDesktopPadding = 81.0;
const appPaddingLarge = 120.0;
const appPaddingSmall = 24.0;

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isSmallDesktop = isDisplaySmallDesktop(context);

    final crossAxisCount = isSmallDesktop
        ? 2
        : isDesktop
            ? 4
            : 1;

    final List<ComponentGroup> componentGroups = [
      ComponentGroup(
        title: ComponentCategory.button.displayTitle(),
        category: ComponentCategory.button,
        icon: Icons.access_time,
        components: buttonComponent(),
      ),
      ComponentGroup(
        title: ComponentCategory.text.displayTitle(),
        category: ComponentCategory.text,
        icon: Icons.access_time,
        components: buttonComponent(),
      ),
      ComponentGroup(
        title: ComponentCategory.list.displayTitle(),
        category: ComponentCategory.list,
        icon: Icons.access_time,
        components: buttonComponent(),
      )
    ];

    return Scaffold(
      body: NestedScrollView(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: _horizontalDesktopPadding,
              bottom: 81,
              end: _horizontalDesktopPadding,
              top: 16,
            ),
            child: StaggeredGridView.countBuilder(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                itemCount: componentGroups.length,
                staggeredTileBuilder: (index) =>
                    index == 0 ? StaggeredTile.fit(crossAxisCount) : const StaggeredTile.fit(1),
                itemBuilder: (BuildContext ctx, index) {
                  final componentGroup = componentGroups[index];
                  return DesktopCategoryItem(
                    category: componentGroup.category,
                    components: componentGroup.components,
                  );
                }),
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: isDesktop ? MediaQuery.of(context).size.height * 0.15: MediaQuery.of(context).size.height * 0.1,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              floating: false,
              pinned: false,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalDesktopPadding,
                  ),
                  child: _CategoriesHeader(),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}

class _CategoriesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Header(
      color: Theme.of(context).colorScheme.primary,
      text: 'Categories',
    );
  }
}
