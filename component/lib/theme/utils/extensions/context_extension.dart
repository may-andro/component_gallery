import 'dart:math';

import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
	bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

	bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;

	double get _pointPerInch => (isAndroid || isIOS) ? 150 : 96;

	EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

	Size get size => MediaQuery.of(this).size;

	double get width => size.width;

	double get height => size.height;

	double get diagonal {
		return sqrt((size.width * size.width) + (size.height * size.height));
	}

	double get diagonalInches => diagonal / _pointPerInch;

	bool get isTablet => diagonalInches >= 7;

	double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

	Brightness get brightness => MediaQuery.of(this).platformBrightness;
}
