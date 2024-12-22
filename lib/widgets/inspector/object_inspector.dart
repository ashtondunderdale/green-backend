import 'package:engine/core/engine.dart';
import 'package:engine/models/cell_entity.dart';
import 'package:engine/models/cell_template.dart';
import 'package:engine/models/scene.dart';
import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class ObjectInspectorPanel extends StatefulWidget {
  const ObjectInspectorPanel({super.key, required this.engine});

  final AsciiEngine engine;

  @override
  State<ObjectInspectorPanel> createState() => _ObjectInspectorPanelState();
}

class _ObjectInspectorPanelState extends State<ObjectInspectorPanel> {
  @override
  Widget build(BuildContext context) {
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
            child: getObjectDisplay()
          ),
        ],
      ),
    );
  }

  Widget getObjectDisplay() {
    final obj = widget.engine.selectedObject;

    return switch (obj) {
      GameScene scene       => displayGameScene(scene),
      CellEntity cell       => displayCellEntity(cell),
      CellTemplate template => displayCellTemplate(template),
      _                     => const SizedBox(),
    };
  }

  Widget displayCellTemplate(CellTemplate template) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cell Template",
          style: engineFont(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
        ),
        Text(
          template.name,
          style: engineFont(
            color: Colors.white
          ),
        ),
        Text(
          template.body,
          style: engineFont(
            color: Colors.white,
            fontSize: 22
          ),
        ),
      ],
    );
  }

  Widget displayCellEntity(CellEntity cell) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cell Entity",
            style: engineFont(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
          Text(
            cell.name,
            style: engineFont(
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
        Text(
          "Game Scene",
          style: engineFont(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
        ),
        Text(
          scene.name,
          style: engineFont(
            color: Colors.white
          ),
        ),
      ],
    );
  }
}