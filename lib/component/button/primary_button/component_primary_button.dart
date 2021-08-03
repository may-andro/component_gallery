import 'package:flutter/material.dart';

class ComponentPrimaryButton extends StatelessWidget {
  final bool disabled;
  final bool loading;

  const ComponentPrimaryButton.normal({
    Key? key,
  })  : disabled = false,
        loading = false,
        super(key: key);

  const ComponentPrimaryButton.loading({
    Key? key,
  })  : disabled = false,
        loading = true,
        super(key: key);

  const ComponentPrimaryButton.disabled({
    Key? key,
  })  : disabled = true,
        loading = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: EdgeInsets.all(12),
      width: double.infinity,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: disabled ? Colors.grey : Color(0xFF030303),
        borderRadius: BorderRadius.circular(8),
      ),
      child: loading
          ? CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.black),
            )
          : Text(
              'Primary Button',
              style: Theme.of(context).textTheme.bodyText1?.apply(color: Color(0xFFEFF3F3)),
            ),
    );
  }
}
