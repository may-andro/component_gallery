import 'package:flutter/material.dart';

class ComponentSecondaryButton extends StatelessWidget {
  final bool loading;

  const ComponentSecondaryButton.normal({
    Key? key,
  })  : loading = false,
        super(key: key);

  const ComponentSecondaryButton.loading({
    Key? key,
  })  : loading = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: EdgeInsets.all(12),
      width: double.infinity,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFF030303),
          width: 1,
        ),
      ),
      child: loading
          ? CircularProgressIndicator(
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          : Text(
              'Secondary Button',
              style: Theme.of(context).textTheme.button?.apply(color: Color(0xFF030303)),
            ),
    );
  }
}
