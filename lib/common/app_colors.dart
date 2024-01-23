import 'dart:ui';

final appColors = AppColors();

class AppColors {
  static final AppColors _appColors = AppColors._internal();

  AppColors._internal();

  factory AppColors() {
    return _appColors;
  }

  Color primary({double opacity = 1}) {
    return Color(0xFF363853).withOpacity(opacity);
  }

  Color secondary({double opacity = 1}) {
    return Color(0xFF00bcd4).withOpacity(opacity);
  }

  Color remark({double opacity = 1}) {
    return Color(0xFFE49393).withOpacity(opacity);
  }

  Color dark({double opacity = 1}) {
    return Color(0xFF76453B).withOpacity(opacity);
  }

  Color light({double opacity = 1}) {
    return Color(0xFFF8FAE5).withOpacity(opacity);
  }

  Color background({double opacity = 1}) {
    return Color(0xFFD8D8D8).withOpacity(opacity);
  }
}
