import 'package:component/theme/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:component/theme/utils/extensions/context_extension.dart';

enum ProminentButtonState { loading, active, inactive }

class ProminentButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ProminentButtonState buttonState;

  const ProminentButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.buttonState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appTheme = context.read(appThemeStateProvider);

      return Material(
        color: getButtonBackgoundColor(buttonState == ProminentButtonState.inactive, context),
        borderRadius: BorderRadius.circular(
          appTheme.getAppThemeDimen().borderRadius,
        ),
        child: InkWell(
          onTap: buttonState == ProminentButtonState.inactive || buttonState == ProminentButtonState.loading
              ? null
              : onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: EdgeInsets.symmetric(
              vertical: appTheme.getAppDimen().padding5_2,
            ),
            width: double.infinity,
            height: 56.0,
            alignment: Alignment.center,
            child: _buildChildWidget(context),
          ),
        ),
      );
    });
  }

  Color getButtonBackgoundColor(bool isInActiveState, BuildContext context) {
    final appTheme = context.read(appThemeStateProvider);
    return isInActiveState ? appTheme.getColorPalette().disableColor: appTheme.getColorPalette().primary;
  }

  Widget _buildChildWidget(BuildContext context) {
    if (buttonState == ProminentButtonState.loading) {
      return _buildLoadingState(context);
    }

    return _buildActiveState(context);
  }

  Widget _buildActiveState(BuildContext context) {
    final appTheme = context.read(appThemeStateProvider);
    return Text(
      label,
      style: appTheme.getTextTheme().buttonPrimary.copyWith(
            color: appTheme.getColorPalette().onPrimary,
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
        color: appTheme.getColorPalette().onPrimary,
        valueColor: AlwaysStoppedAnimation(appTheme.getColorPalette().onPrimary),
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
