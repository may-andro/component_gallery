import 'package:component/theme/utils/enums/screen_size.dart';

extension ScreenSizeExtension on ScreenSize {
  double get screenGrid {
    switch (this) {
      case ScreenSize.small:
        return 6.0;
      case ScreenSize.large:
        return 16.0;
      case ScreenSize.medium:
      default:
        return 8.0;
    }
  }
}
