import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../core/engine.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int cols = 24; // Default columns
  final int rows = 14; // Default rows

  double cellSize = 42; // Default cell size
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
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: borderWidth),
        ),
        child: _buildGrid(engine, dynamicCols, dynamicRows),
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
          if (engine.isGameMode) return;
          engine.addSceneObject(row, col);
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
          child: _buildCellValue(engine, row, col),
        ),
      ),
    );
  }

  Widget _buildCellValue(AsciiEngine engine, int row, int col) {
    if (engine.activeScene == null) {
      return Center(
        child: Text(
          "",
          style: TextStyle(
            color: Colors.white,
            fontSize: cellSize / 1.6,
          ),
        ),
      );
    }

    return Center(
      child: Text(
        engine.activeScene!.cells
            .where((x) => x.xPos == row && x.yPos == col)
            .firstOrNull
            ?.body ??
            "",
        style: TextStyle(
          color: Colors.white,
          fontSize: cellSize / 1.6,
        ),
      ),
    );
  }
}

