import 'package:flutter/material.dart';

class ComponentProminentButton extends StatelessWidget {
  final bool disabled;
  final bool loading;

  const ComponentProminentButton.normal({
    Key? key,
  })  : disabled = false,
        loading = false,
        super(key: key);

  const ComponentProminentButton.loading({
    Key? key,
  })  : disabled = false,
        loading = true,
        super(key: key);

  const ComponentProminentButton.disabled({
    Key? key,
  })  : disabled = true,
        loading = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(12),
      duration: const Duration(milliseconds: 350),
      width: double.infinity,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: disabled ? Colors.grey : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: loading
          ? CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          : Text(
              'Prominent Button',
              style: Theme.of(context).textTheme.button?.apply(color: Color(0xFFEFF3F3)),
            ),
    );
  }
}
