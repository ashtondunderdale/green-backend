import 'package:engine/core/engine.dart';
import 'package:engine/widgets/console/engine_console.dart';
import 'package:engine/widgets/grid/ascii_grid.dart';
import 'package:engine/widgets/explorer/object_explorer.dart';
import 'package:engine/widgets/inspector/object_inspector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EngineView extends StatefulWidget {
  const EngineView({super.key});

  @override
  State<EngineView> createState() => _EngineViewState();
}

class _EngineViewState extends State<EngineView> {  
  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      body: Row(
        children: [
          if (!engine.isGameMode)
            const ObjectExplorerPanel(),

          Expanded(
            child: Column(
              children: [
                const GameScreen(),
                const Spacer(),
                
              if (!engine.isGameMode) const EngineConsole(),
              ],
            ),
          ),

          if (!engine.isGameMode) 
            ObjectInspectorPanel(selectedObject: engine.selectedObject),
        ],
      ),
    );
  }
}
