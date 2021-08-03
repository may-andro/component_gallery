import 'package:component_gallery/utils/adaptive.dart';
import 'package:component_gallery/utils/constants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.color, required this.text}) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: isDisplayDesktop(context) ? 63 : 15,
        bottom: isDisplayDesktop(context) ? 21 : 11,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4?.apply(
              color: color,
              fontSizeDelta: isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
            ),
      ),
    );
  }
}
