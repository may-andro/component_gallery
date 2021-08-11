import 'package:flutter/material.dart';
import 'package:component/button/primary_button.dart';

class ConfigLargePrimaryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton.large(
      label: 'Primary Button',
      onPressed: () {},
      buttonState: PrimaryButtonState.active,
    );
  }
}
