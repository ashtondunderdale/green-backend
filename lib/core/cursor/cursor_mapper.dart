import 'package:flutter/services.dart';
import 'cursor_mode.dart';

class CursorMapper {
  static SystemMouseCursor map(CursorMode mode) {
    return switch (mode) {
      CursorMode.select => SystemMouseCursors.grab,
      CursorMode.object => SystemMouseCursors.click,
      CursorMode.delete => SystemMouseCursors.disappearing,
    };
  }
}