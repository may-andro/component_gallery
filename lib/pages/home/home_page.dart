import 'dart:collection';

import 'package:component_gallery/pages/dashboard/dashboard_page.dart';
import 'package:component_gallery/pages/dashboard/widget/header.dart';
import 'package:component_gallery/pages/setting/model/setting_item.dart';
import 'package:component_gallery/pages/setting/setting_page.dart';
import 'package:component_gallery/utils/adaptive.dart';
import 'package:component_gallery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_provider.dart';

const homePeekDesktop = 210.0;
const homePeekMobile = 60.0;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    this.settingsPage,
    this.dashboardPage,
  }) : super(key: key);

  final Widget? settingsPage;
  final Widget? dashboardPage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _settingsPanelController;
  late AnimationController _iconController;
  late Widget _settingsPage;
  late Widget _dashboardPage;

  @override
  void initState() {
    super.initState();
    _settingsPanelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _settingsPage = widget.settingsPage ?? SettingPage();
    _dashboardPage = widget.dashboardPage ?? const DashboardPage();
  }

  @override
  void dispose() {
    _settingsPanelController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Animation<RelativeRect> _slideDownSettingsPageAnimation(BoxConstraints constraints) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, -constraints.maxHeight, 0, 0),
      end: const RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(
      CurvedAnimation(
        parent: _settingsPanelController,
        curve: const Interval(
          0.0,
          0.4,
          curve: Curves.ease,
        ),
      ),
    );
  }

  Animation<RelativeRect> _slideDownHomePageAnimation(BoxConstraints constraints) {
    return RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: RelativeRect.fromLTRB(
        0,
        constraints.biggest.height - galleryHeaderHeight,
        0,
        -galleryHeaderHeight,
      ),
    ).animate(
      CurvedAnimation(
        parent: _settingsPanelController,
        curve: const Interval(
          0.0,
          0.4,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        var frontLayer = _buildStack(context, constraints);
        if (isDisplayDesktop(context)) {
          frontLayer = Padding(
            padding: const EdgeInsets.only(top: 136),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              child: frontLayer,
            ),
          );
        }

        return Stack(
          children: [
            Container(
              // This is the background color of the gifs.
              color: const Color(0xFF030303),
              padding: EdgeInsets.only(
                bottom: isDisplayDesktop(context) ? homePeekDesktop : homePeekMobile,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Component Gallery',
                    style: Theme.of(context).textTheme.headline6?.apply(
                          color: Theme.of(context).colorScheme.primary,
                          fontSizeDelta: isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: frontLayer,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final isDesktop = isDisplayDesktop(context);

    final Widget settingsPage = _settingsPage;

    final Widget dashboardPage = _dashboardPage;

    return Consumer(builder: (context, watch, child) {
      final homeState = watch(homeStateProvider);
      final isSettingsOpen = homeState.isSettingsOpen();
      return Stack(
        children: [
          if (!isDesktop) ...[
            // Slides the settings page up and down from the top of the
            // screen.
            PositionedTransition(
              rect: _slideDownSettingsPageAnimation(constraints),
              child: settingsPage,
            ),
            // Slides the home page up and down below the bottom of the
            // screen.
            PositionedTransition(
              rect: _slideDownHomePageAnimation(constraints),
              child: dashboardPage,
            ),
          ],
          if (isDesktop) ...[
            dashboardPage,
            isSettingsOpen
                ? Listener(
                    onPointerDown: (_) => _toggleSettings(context),
                    child: const ModalBarrier(dismissible: false),
                  )
                : Container(),
            ScaleTransition(
              alignment: Directionality.of(context) == TextDirection.ltr ? Alignment.topRight : Alignment.topLeft,
              scale: CurvedAnimation(
                parent: _settingsPanelController,
                curve: Curves.easeIn,
                reverseCurve: Curves.easeOut,
              ),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: Material(
                  elevation: 7,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(40),
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 560,
                      maxWidth: desktopSettingsWidth,
                      minWidth: desktopSettingsWidth,
                    ),
                    child: settingsPage,
                  ),
                ),
              ),
            ),
          ],
          _SettingsIcon(
            animationController: _iconController,
            toggleSettings: () => _toggleSettings(context),
          ),
        ],
      );
    });
  }

  void _toggleSettings(BuildContext context) {
    final homeStateNotifier = context.read(homeStateProvider.notifier);
    final homeState = context.read(homeStateProvider);
    final isSettingsOpen = homeState.isSettingsOpen();
    // Animate the settings panel to open or close.
    if (isSettingsOpen) {
      _settingsPanelController.reverse();
      _iconController.reverse();
    } else {
      _settingsPanelController.forward();
      _iconController.forward();
    }
    homeStateNotifier.setIsSettingsOpen(!isSettingsOpen);
  }
}

const double _settingsButtonWidth = 64;
const double _settingsButtonHeightDesktop = 56;
const double _settingsButtonHeightMobile = 40;

class _SettingsIcon extends AnimatedWidget {
  const _SettingsIcon({
    required this.animationController,
    required this.toggleSettings,
  }) : super(listenable: animationController);

  final AnimationController animationController;
  final VoidCallback toggleSettings;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Consumer(builder: (context, watch, child) {
      final homeState = watch(homeStateProvider);
      final isSettingsOpen = homeState.isSettingsOpen();
      return Align(
        alignment: AlignmentDirectional.topEnd,
        child: SizedBox(
          width: _settingsButtonWidth,
          height: isDesktop ? _settingsButtonHeightDesktop : _settingsButtonHeightMobile + safeAreaTopPadding,
          child: Material(
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
            ),
            color: isSettingsOpen & !animationController.isAnimating
                ? Colors.transparent
                : Theme.of(context).colorScheme.secondaryVariant,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                toggleSettings();
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 3, end: 18),
                child: Icon(Icons.settings),
              ),
            ),
          ),
        ),
      );
    });
  }
}
