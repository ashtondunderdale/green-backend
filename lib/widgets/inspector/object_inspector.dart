import 'package:engine/core/engine.dart';
import 'package:engine/models/cell_entity.dart';
import 'package:engine/models/game_object.dart';
import 'package:engine/models/scene.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/globals.dart';

class ObjectInspectorPanel extends StatefulWidget {
  const ObjectInspectorPanel({super.key});

  @override
  State<ObjectInspectorPanel> createState() => _ObjectInspectorPanelState();
}

class _ObjectInspectorPanelState extends State<ObjectInspectorPanel> {
  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    return Container(
      width: objectExplorerWidth,
      decoration: const BoxDecoration(
        color: panelColour,
        border: Border(
          left: BorderSide(
            color: Colors.white,
            width: borderWidth,
          )
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: getObjectDisplay(engine.selectedObject)
          ),
        ],
      ),
    );
  }

  Widget getObjectDisplay(GameObject? obj) {
    if (obj == null) return const SizedBox();

    if (obj is GameScene) {
      return displayGameScene(obj);
    }

    if (obj is CellEntity) {
      return displayCellEntity(obj);
    }

    return const SizedBox();
  }

  Widget displayCellEntity(CellEntity cell) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cell Entity",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
          Text(
            cell.name,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        ],
      );
    }

  Widget displayGameScene(GameScene scene) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Game Scene",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
        ),
        Text(
          scene.name,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ],
    );
  }
}