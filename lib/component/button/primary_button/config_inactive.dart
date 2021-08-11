import 'package:flutter/material.dart';
import 'package:component/button/primary_button.dart';

class ConfigInActivePrimaryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton.normal(
      label: 'Primary Button',
      onPressed: () {},
      buttonState: PrimaryButtonState.inactive,
    );
  }
}
