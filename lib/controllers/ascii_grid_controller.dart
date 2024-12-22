import 'package:engine/core/engine.dart';
import 'package:flutter/material.dart';

import '../core/cursor/cursor_mode.dart';

final class AsciiGridController with ChangeNotifier {
  void onCellClick(AsciiEngine engine, int row, int col) {
    if (engine.isGameMode) return;
    if (engine.selectedTemplate == null) return;
    if (engine.activeScene == null) return;

    final cellAtXY = engine.activeScene!.cells
      .where((x) => x.xPos == row && x.yPos == col).firstOrNull;

    if (engine.cursorMode == CursorMode.object) {
      if (cellAtXY != null) return;
      engine.addCellEntity(row, col);
    } 
    else if (engine.cursorMode == CursorMode.select) {
      if (cellAtXY == null) return;
      engine.setSelectedObject(cellAtXY);
    }
    else if (engine.cursorMode == CursorMode.delete) {
      if (cellAtXY == null) return;
      engine.removeCellEntity(cellAtXY);
    }
  }
}