import 'package:engine/controllers/ascii_grid_controller.dart';
import 'package:engine/models/cell_entity.dart';
import 'package:engine/widgets/grid/arrow_compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/globals.dart';
import '../../core/engine.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.controller, required this.engine});

  final AsciiEngine engine;
  final AsciiGridController controller;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int cols = 24;
  final int rows = 14;

  double cellSize = 42;
  final Map<String, bool> hoverState = {};
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onKey(AsciiEngine engine, KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
      engine.setGameMode(false);
    }
  }

  CellEntity? getCellFromXY(int xPos, int yPos) {
    if (widget.engine.activeScene == null) return null;

    return widget.engine.activeScene!.cells
      .where((x) => x.xPos == xPos && x.yPos == yPos).firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    double screenWidth = MediaQuery.sizeOf(context).width - objectExplorerWidth * 2;
    double screenHeight = MediaQuery.sizeOf(context).height - consoleHeight;

    cellSize = (screenWidth / cols).clamp(30.0, 60.0);

    int dynamicCols = (screenWidth / cellSize).floor();
    int dynamicRows = (screenHeight / cellSize).floor();

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        _onKey(engine, event);
        return KeyEventResult.handled;
      },
      child: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            _buildGrid(engine, dynamicCols, dynamicRows),
            ArrowCompass(engine: widget.engine)
          ],
        )
      ),
    );
  }

  Widget _buildGrid(AsciiEngine engine, int dynamicCols, int dynamicRows) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: dynamicCols,
      ),
      itemCount: dynamicRows * dynamicCols,
      itemBuilder: (context, idx) {
        final row = idx ~/ dynamicCols;
        final col = idx % dynamicCols;

        return _buildCell(engine, row, col);
      },
    );
  }

  Widget _buildCell(AsciiEngine engine, int row, int col) {
    final key = "$row-$col";

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoverState[key] = true;
        });
      },
      onExit: (_) {
        setState(() {
          hoverState[key] = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.controller.onCellClick(engine, row, col);
        },
        child: Container(
          width: cellSize,
          height: cellSize,
          decoration: BoxDecoration(
            color: hoverState[key] == true && !engine.isGameMode
                ? const Color.fromARGB(255, 17, 17, 17)
                : Colors.black,
            border: engine.isGameMode
                ? null
                : Border.all(
                    color: const Color.fromARGB(255, 109, 109, 109),
                    width: 0.1,
                  ),
          ),
          child: _buildCellValue(row, col),
        ),
      ),
    );
  }

  Widget _buildCellValue(int row, int col) {
    double cellSizeFactor = 1.4;

    if (widget.engine.activeScene == null) {
      return Center(
        child: Text(
          "",
          style: engineFont(
            color: Colors.white,
            fontSize: cellSize / cellSizeFactor,
          ),
        ),
      );
    }

    final obj = getCellFromXY(row, col);

    if (obj == widget.engine.selectedObject) {
      return Container(
        width: cellSize, height: cellSize,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1)
        ),
        child: Center(
          child: Text(
            obj?.body ?? "",
            style: engineFont(
              color: Colors.white,
              fontSize: cellSize / cellSizeFactor,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Text(
        obj?.body ?? "",
        style: engineFont(
          color: Colors.white,
          fontSize: cellSize / cellSizeFactor,
        ),
      ),
    );
  }
}

