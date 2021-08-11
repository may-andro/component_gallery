import 'package:component/theme/utils/enums/screen_size.dart';

import 'package:component/theme/utils/extensions/screen_size_extension.dart';

class AppDimens {
  final ScreenSize _screenSize;

  AppDimens(this._screenSize);

  double get _grid => _screenSize.screenGrid;

  double get padding1_4 => _grid / 4;

  double get padding1_2 => _grid / 2;

  double get padding3_4 => _grid * 0.75;

  double get padding => _grid;

  double get padding3_2 => _grid * 1.5;

  double get padding2X => _grid * 2;

  double get padding5_2 => _grid * 2.5;

  double get padding3X => _grid * 3;

  double get padding4X => _grid * 4;

  double get padding5X => _grid * 5;

  double get padding6X => _grid * 6;
}
