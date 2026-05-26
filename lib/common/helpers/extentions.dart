import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  Size get media {
    return MediaQuery.sizeOf(this);
  }

  ThemeData get theme {
    return Theme.of(this);
  }
}
