import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../core/engine.dart';
import '../common/engine_button.dart';

class GridButtonsTab extends StatefulWidget {
  const GridButtonsTab({super.key});

  @override
  State<GridButtonsTab> createState() => _GridButtonsTabState();
}

class _GridButtonsTabState extends State<GridButtonsTab> {
  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: gridButtonsTabHeight,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white, 
            width: borderWidth
          ),
        ),
        child: Row(
          children: [
            EngineButton(
              text: "Game", 
              onClick: () {
                engine.setGameMode(true);
              }
            ),
            EngineButton(
              text: "Editor", 
              onClick: () {
                engine.setGameMode(false);
              }
            ),
          ],
        ),
      ),
    );
  }
}