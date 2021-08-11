import 'package:component/theme/app_theme_provider.dart';
import 'package:component/theme/utils/enums/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:component/theme/utils/extensions/context_extension.dart';

enum SecondaryButtonState { loading, active, inactive }

const double borderWidth = 2.0;

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLarge;
  final SecondaryButtonState buttonState;

  const SecondaryButton.normal({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.buttonState,
  })  : isLarge = false,
        super(key: key);

  const SecondaryButton.large({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.buttonState,
  })  : isLarge = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appTheme = context.read(appThemeStateProvider);

      return Material(
        color: getButtonBackgoundColor(buttonState == SecondaryButtonState.inactive, context),
        shape: appTheme.getDesignSystem() == DesignSystem.ocean_blue
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: appTheme.getColorPalette().secondary,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(
                  appTheme.getAppThemeDimen().borderRadius,
                ),
              )
            : Border.all(
                color: appTheme.getColorPalette().secondary,
                width: borderWidth,
              ),
        child: InkWell(
          onTap: buttonState == SecondaryButtonState.inactive || buttonState == SecondaryButtonState.loading
              ? null
              : onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: EdgeInsets.symmetric(
              vertical: isLarge == true ? appTheme.getAppDimen().padding2X : appTheme.getAppDimen().padding3_2,
            ),
            width: double.infinity,
            alignment: Alignment.center,
            child: _buildChildWidget(context),
          ),
        ),
      );
    });
  }

  Color getButtonBackgoundColor(bool isInActiveState, BuildContext context) {
    final appTheme = context.read(appThemeStateProvider);
    return isInActiveState ? appTheme.getColorPalette().secondary : appTheme.getColorPalette().disableColor;
  }

  Widget _buildChildWidget(BuildContext context) {
    if (buttonState == SecondaryButtonState.loading) {
      return _buildLoadingState(context);
    }

    return _buildActiveState(context);
  }

  Widget _buildActiveState(BuildContext context) {
    final appTheme = context.read(appThemeStateProvider);
    return Text(
      label,
      style: appTheme.getTextTheme().buttonPrimary.copyWith(
            color: appTheme.getColorPalette().onSecondary,
          ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final appTheme = context.read(appThemeStateProvider);
    return SizedBox(
      width: 100.0,
      height: _getAnimationHeight(context),
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: appTheme.getColorPalette().onSecondary,
        valueColor: AlwaysStoppedAnimation(appTheme.getColorPalette().onSecondary),
      ),
    );
  }

  double _getAnimationHeight(BuildContext context) {
    final appTheme = context.read(appThemeStateProvider);

    return (appTheme.getTextTheme().buttonPrimary.fontSize ??
            1.0 * (appTheme.getTextTheme().buttonPrimary.height ?? 1.0)) *
        context.textScaleFactor;
  }
}
