import 'package:flutter/material.dart';
import 'package:component/button/prominent_button.dart';

class ConfigInActiveProminentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProminentButton(
      label: 'Prominent Button',
      onPressed: () {},
      buttonState: ProminentButtonState.inactive,
    );
  }
}
