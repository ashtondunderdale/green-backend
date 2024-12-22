import 'package:engine/core/cursor/cursor_mode.dart';
import 'package:engine/models/cell_template.dart';
import 'package:engine/models/game_object.dart';
import 'package:engine/models/scene.dart';
import 'package:engine/models/cell_entity.dart';
import 'package:engine/utils/globals.dart';
import 'package:flutter/material.dart';

import 'cursor/cursor_mapper.dart';

final class AsciiEngine with ChangeNotifier {
  bool isGameMode = false;

  CursorMode cursorMode = CursorMode.select;

  GameScene? activeScene;
  List<GameScene> gameScenes = [];

  GameObject? selectedObject;

  CellTemplate? selectedTemplate;
  List<CellTemplate> cellTemplates = [];

  void setCursorMode(CursorMode mode) {
    cursorMode = mode;
    activeCursor = CursorMapper.map(mode);

    notifyListeners();
  }

  void setSelectedTemplate(final CellTemplate template) {
    selectedTemplate = template;
    notifyListeners();
  }

  void addTemplate(final CellTemplate obj) {
    cellTemplates.add(obj);
    notifyListeners();
  }

  void setGameMode(final bool mode) {
    isGameMode = mode;
    notifyListeners();
  }

  void addScene(final GameScene scene) {
    gameScenes.add(scene);
    notifyListeners();
  }

  void setSelectedObject(final GameObject obj) {
    selectedObject = obj;
    notifyListeners();
  }

  void setScene(final GameScene scene) {
    activeScene = scene;
    notifyListeners();
  }

  void updateCell(CellEntity cell) {
    notifyListeners();
  }

  void addCellEntity(final int x, final int y) {
    final cell = CellEntity(
      name: _getNextObjectName(),
      body: selectedTemplate!.body,
      xPos: x, yPos: y
    );

    activeScene!.cells.add(cell);
    notifyListeners();
  }

  void removeCellEntity(CellEntity cell) {
    activeScene!.cells.remove(cell);
    notifyListeners();
  }

  String _getNextObjectName() {
    int largestCellNameNum = 0;

    for (var cell in activeScene!.cells) {
      final nameParts = cell.name.split(" ");
      
      if (nameParts.length > 1) {
        final num = nameParts[1];

        final intNum = int.parse(num);
        if (intNum > largestCellNameNum) {
          largestCellNameNum = intNum;
        }
      }
    }

    return "Cell ${largestCellNameNum + 1}";
  }
}