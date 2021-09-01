import 'package:component_gallery/app/app_provider.dart';
import 'package:component_gallery/app/gallery_theme_data.dart';
import 'package:component_gallery/model/component.dart';
import 'package:component_gallery/pages/component_demo/widget/component_code_widget.dart';
import 'package:component_gallery/pages/component_demo/widget/component_config_widget.dart';
import 'package:component_gallery/pages/component_demo/widget/component_info_widget.dart';
import 'package:component_gallery/pages/component_demo/widget/mobile_frame_widget.dart';
import 'package:component_gallery/pages/component_demo/widget/source_code_view_widget.dart';
import 'package:component_gallery/pages/component_demo/widget/syntax_highlighter.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'component_demo_provider.dart';
import 'component_demo_state.dart';

const componentDemoPeekDesktop = 210.0;
const componentDemoPeekMobile = 60.0;

class ComponentDemoPage extends StatefulWidget {
  const ComponentDemoPage({Key? key, required this.component}) : super(key: key);

  final Component component;

  @override
  _ComponentDemoPageState createState() => _ComponentDemoPageState();
}

class _ComponentDemoPageState extends State<ComponentDemoPage> with TickerProviderStateMixin {
  late AnimationController _codeBackgroundColorController;

  @override
  void initState() {
    super.initState();
    print('_ComponentDemoPageState.initState ${widget.component.title}');
    _codeBackgroundColorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _codeBackgroundColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appState = context.read(appStateProvider);
      watch(componentDemoStateProvider);

      final isDesktop = isDisplayDesktop(context);

      final AppBar appBar = _buildAppBar(context);

      final mediaQuery = MediaQuery.of(context);
      final contentHeight =
          mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom - appBar.preferredSize.height;
      final maxSectionHeight = isDesktop ? contentHeight : contentHeight - 64;
      final maxSectionWidth = isDesktop ? mediaQuery.size.width * 0.4 : double.infinity;

      final Widget section = _buildSection(
        context,
        maxSectionHeight,
        maxSectionWidth,
      );

      final Widget body = _buildBody(
        context,
        contentHeight,
        section,
      );

      Widget page = _buildPage(context, appBar, body, appState.getComponentGalleryOptions().themeMode);

      return Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return page;
        }),
      );
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    final componentDemoState = context.read(componentDemoStateProvider);
    final componentDemoStateNotifier = context.read(componentDemoStateProvider.notifier);

    final currentDemoState = componentDemoState.getSelectedDemoState();

    final isDesktop = isDisplayDesktop(context);
    final colorScheme = Theme.of(context).colorScheme;
    final appBarPadding = isDesktop ? 16.0 : 0.0;

    final iconColor = colorScheme.onSurface;
    final selectedIconColor = colorScheme.primary;

    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: appBarPadding),
        child: IconButton(
          key: const ValueKey('Back'),
          icon: const BackButtonIcon(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info),
          tooltip: 'Information',
          color: currentDemoState == DemoState.info ? selectedIconColor : iconColor,
          onPressed: () => _handleTap(DemoState.info, currentDemoState, componentDemoStateNotifier),
        ),
        IconButton(
          icon: const Icon(Icons.code),
          tooltip: 'Code',
          color: currentDemoState == DemoState.code ? selectedIconColor : iconColor,
          onPressed: () => _handleTap(DemoState.code, currentDemoState, componentDemoStateNotifier),
        ),
        SizedBox(width: appBarPadding),
      ],
    );
  }

  void _handleTap(
    DemoState newState,
    DemoState currentDemoState,
    ComponentDemoStateNotifier componentDemoStateNotifier,
  ) {
    if (newState != currentDemoState) {
      if (newState == DemoState.code) {
        _codeBackgroundColorController.forward();
      } else {
        _codeBackgroundColorController.reverse();
      }
      componentDemoStateNotifier.setSelectedDemoState(newState);
    }
  }

  Widget _buildSection(
    BuildContext context,
    double maxSectionHeight,
    double maxSectionWidth,
  ) {
    final componentDemoState = context.read(componentDemoStateProvider);
    final componentDemoStateNotifier = context.read(componentDemoStateProvider.notifier);

    final currentDemoState = componentDemoState.getSelectedDemoState();
    final currentConfigIndex = componentDemoState.getSelectedConfigIndex();
    final currentComponentConfiguration = widget.component.configurations[currentConfigIndex];

    late Widget section;
    switch (currentDemoState) {
      case DemoState.info:
        section = Column(
          children: [
            ComponentInfoWidget(
              maxHeight: maxSectionHeight,
              maxWidth: maxSectionWidth,
              title: currentComponentConfiguration.title,
              description: currentComponentConfiguration.description,
            ),
            ComponentConfigWidget(
              maxHeight: maxSectionHeight,
              maxWidth: maxSectionWidth,
              configurations: widget.component.configurations,
              configIndex: currentConfigIndex,
              onConfigChanged: (index) {
                componentDemoStateNotifier.setSelectedConfigIndex(index);
              },
            ),
          ],
        );
        break;
      case DemoState.code:
        section = ComponentCodeWidget(
          maxHeight: maxSectionHeight,
          maxWidth: maxSectionWidth,
          codeWidget: SourceCodeView(
            // filePath: 'lib/main.dart',
            filePath: currentComponentConfiguration.widgetPath,
            iconBackgroundColor: Colors.white,
            iconForegroundColor: Colors.pink,
            labelBackgroundColor: Theme.of(context).canvasColor,
            labelTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),
            showLabelText: true,
            syntaxHighlighterStyle: SyntaxHighlighterStyle.darkThemeStyle().copyWith(
              commentStyle: TextStyle(color: Colors.yellow),
              keywordStyle: TextStyle(color: Colors.lightGreen),
              classStyle: TextStyle(color: Colors.amber),
              numberStyle: TextStyle(color: Colors.orange),
            ),
          ),
        );
        break;
      default:
        section = SizedBox.shrink();
        break;
    }
    return section;
  }

  Widget _buildBody(
    BuildContext context,
    double contentHeight,
    Widget section,
  ) {
    final componentDemoState = context.read(componentDemoStateProvider);

    final currentConfigIndex = componentDemoState.getSelectedConfigIndex();
    final currentComponentConfiguration = widget.component.configurations[currentConfigIndex];

    final isDesktop = isDisplayDesktop(context);
    final mediaQuery = MediaQuery.of(context);
    final bottomSafeArea = mediaQuery.padding.bottom;

    late Widget body;
    Widget demoContent = ScaffoldMessenger(
      child: MobileFrameWidget(
        height: contentHeight,
        widget: currentComponentConfiguration.widget,
        title: currentComponentConfiguration.title,
      ),
    );

    if (isDesktop) {
      final Widget sectionAndDemo = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: section),
          SizedBox(
            width: 48.0,
          ),
          Expanded(child: demoContent),
        ],
      );

      body = SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: sectionAndDemo,
        ),
      );
    } else {
      section = AnimatedSize(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        curve: Curves.easeIn,
        child: section,
      );

      body = SafeArea(
        bottom: false,
        child: ListView(
          // Use a non-scrollable ListView to enable animation of shifting the
          // demo offscreen.
          physics: const NeverScrollableScrollPhysics(),
          children: [
            section,
            demoContent,
            // Fake the safe area to ensure the animation looks correct.
            SizedBox(height: bottomSafeArea),
          ],
        ),
      );
    }

    return body;
  }

  Widget _buildPage(
    BuildContext context,
    AppBar appBar,
    Widget body,
    ThemeMode themeMode,
  ) {
    late Widget page;
    final isDesktop = isDisplayDesktop(context);
    final horizontalPadding = isDesktop ? 81.0 : 0.0;
    final colorScheme = Theme.of(context).colorScheme;

    if (isDesktop) {
      page = AnimatedBuilder(
          animation: _codeBackgroundColorController,
          builder: (context, child) {
            Brightness themeBrightness;

            switch (themeMode) {
              case ThemeMode.system:
                themeBrightness = MediaQuery.of(context).platformBrightness;
                break;
              case ThemeMode.light:
                themeBrightness = Brightness.light;
                break;
              case ThemeMode.dark:
                themeBrightness = Brightness.dark;
                break;
            }

            Widget contents = Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Scaffold(
                appBar: appBar,
                body: body,
                backgroundColor: Colors.transparent,
              ),
            );

            if (themeBrightness == Brightness.light) {
              // If it is currently in light mode, add a
              // dark background for code.
              Widget codeBackground = Container(
                padding: const EdgeInsets.only(top: 56),
                child: Container(
                  color: ColorTween(
                    begin: Colors.transparent,
                    end: GalleryThemeData.darkThemeData.canvasColor,
                  ).animate(_codeBackgroundColorController).value,
                ),
              );

              contents = Stack(
                children: [
                  codeBackground,
                  contents,
                ],
              );
            }

            return Container(
              color: colorScheme.background,
              child: contents,
            );
          });
    } else {
      page = Container(
        color: colorScheme.background,
        child: Scaffold(
          appBar: appBar,
          body: body,
          resizeToAvoidBottomInset: false,
        ),
      );
    }
    return page;
  }
}
