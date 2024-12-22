import 'package:engine/core/engine.dart';
import 'package:engine/models/cell_entity.dart';
import 'package:flutter/material.dart';

class ArrowCompass extends StatefulWidget {
  const ArrowCompass({super.key, required this.engine});

  final AsciiEngine engine;

  @override
  State<ArrowCompass> createState() => _ArrowCompassState();
}

class _ArrowCompassState extends State<ArrowCompass> {

  bool cellExistsAt(int xPos, int yPos) {
    if (widget.engine.activeScene == null) return false;

    return widget.engine.activeScene!.cells
      .where((x) => x.xPos == xPos && x.yPos == yPos).firstOrNull != null;
  }

  @override
  Widget build(BuildContext context) {
    final selectedObj = widget.engine.selectedObject;

    return SizedBox(
      width: 110, height: 110,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 40,
            child: GestureDetector(
              onTap: () {
                if (selectedObj is CellEntity) {
                  if (!cellExistsAt(selectedObj.xPos - 1, selectedObj.yPos)) {
                    selectedObj.xPos--;
                    widget.engine.updateCell(selectedObj);
                  }
                }
              },
              child: const Icon(
                Icons.keyboard_arrow_up,
                size: 32,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 40,
            child: GestureDetector(
              onTap: () {
                if (selectedObj is CellEntity) {
                  if (!cellExistsAt(selectedObj.xPos + 1, selectedObj.yPos)) {
                    selectedObj.xPos++;
                    widget.engine.updateCell(selectedObj);
                  }
                }
              },
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 32,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: GestureDetector(
              onTap: () {
                if (selectedObj is CellEntity) {
                  if (!cellExistsAt(selectedObj.xPos, selectedObj.yPos -1)) {
                    selectedObj.yPos--;
                    widget.engine.updateCell(selectedObj);
                  }
                }
              },
              child: const Icon(
                Icons.keyboard_arrow_left,
                size: 32,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (selectedObj is CellEntity) {
                  if (!cellExistsAt(selectedObj.xPos, selectedObj.yPos + 1)) {
                    selectedObj.yPos++;
                    widget.engine.updateCell(selectedObj);
                  }
                }
              },
              child: const Icon(
                Icons.keyboard_arrow_right,
                size: 32,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}