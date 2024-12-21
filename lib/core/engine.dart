import 'package:engine/models/scene.dart';
import 'package:engine/models/cell_entity.dart';
import 'package:flutter/material.dart';

import '../models/game_object.dart';

final class AsciiEngine with ChangeNotifier {
  bool isGameMode = false;

  GameScene? activeScene;
  List<GameScene> gameScenes = [];

  GameObject? selectedObject;
  List<GameObject> objectList = [];

  void setSelectedObject(final GameObject obj) {
    selectedObject = obj;
    notifyListeners();
  }

  void addObject(final GameObject obj) {
    objectList.add(obj);
    notifyListeners();
  }

  void setGameMode(final bool mode) {
    if (mode == isGameMode) return;
    
    isGameMode = mode;
    notifyListeners();
  }

  void addScene(final GameScene scene) {
    gameScenes.add(scene);
    notifyListeners();
  }

  void setScene(final GameScene scene) {
    activeScene = scene;
    notifyListeners();
  }

  void addSceneObject(final int x, final int y) {
    if (selectedObject == null || activeScene == null) return;

    final cell = CellEntity(
      body: selectedObject!.body,
      xPos: x, yPos: y
    );

    activeScene!.cells.add(cell);
    notifyListeners();
  }
}