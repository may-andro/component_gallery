import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/pages/component_demo/component_demo_page.dart';
import 'package:component_gallery/pages/dashboard/widget/component_search_list_widget.dart';
import 'package:component_gallery/pages/dashboard/widget/desktop_dashboard_widget.dart';
import 'package:component_gallery/utils/component_group_list_constant.dart';
import 'package:component_gallery/widgets/responsive_container_widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  void goToNextPage(BuildContext context, Component component) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComponentDemoPage(component: component),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: ResponsiveContainerWidget(
        mobile: _buildMobileContent(context),
        tablet: _buildTabletContent(context),
        desktop: _buildDesktopContent(context),
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return ComponentSearchListWidget(
      componentGroupList: componentGroupList,
      onComponentClick: (component) {
        goToNextPage(context, component);
      },
      componentSearchListType: ComponentSearchListType.expandableList,
    );
  }

  Widget _buildTabletContent(BuildContext context) {
    return ComponentSearchListWidget(
      componentGroupList: componentGroupList,
      onComponentClick: (component) {
        goToNextPage(context, component);
      },
      componentSearchListType: ComponentSearchListType.staggeredList,
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return DesktopDashboardWidget(
      componentGroupList: componentGroupList,
      onComponentClick: (component) {
        goToNextPage(context, component);
      },
    );
  }
}
