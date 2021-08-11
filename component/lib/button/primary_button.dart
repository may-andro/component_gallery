import 'package:component/theme/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:component/theme/utils/extensions/context_extension.dart';

enum PrimaryButtonState { loading, active, inactive }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLarge;
  final PrimaryButtonState buttonState;

  const PrimaryButton.normal({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.buttonState,
  })  : isLarge = false,
        super(key: key);

  const PrimaryButton.large({
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
        color: getButtonBackgoundColor(buttonState == PrimaryButtonState.inactive, context),
        borderRadius: BorderRadius.circular(
          appTheme.getAppThemeDimen().borderRadius,
        ),
        child: InkWell(
          onTap: buttonState == PrimaryButtonState.inactive || buttonState == PrimaryButtonState.loading
              ? null
              : onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            height: isLarge ? 72 : 56,
            padding: EdgeInsets.symmetric(
              vertical: isLarge ? appTheme.getAppDimen().padding2X : appTheme.getAppDimen().padding3_2,
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
    return isInActiveState ? appTheme.getColorPalette().disableColor : appTheme.getColorPalette().secondary;
  }

  Widget _buildChildWidget(BuildContext context) {
    if (buttonState == PrimaryButtonState.loading) {
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
