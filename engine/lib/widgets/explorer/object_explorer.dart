import 'package:engine/widgets/explorer/game_objects_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:engine/models/scene.dart';
import 'package:engine/widgets/common/engine_button.dart';

import '../../constants/constants.dart';
import '../../core/engine.dart';

class ObjectExplorerPanel extends StatefulWidget {
  const ObjectExplorerPanel({super.key});

  @override
  State<ObjectExplorerPanel> createState() => _ObjectExplorerPanelState();
}

class _ObjectExplorerPanelState extends State<ObjectExplorerPanel> {
  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    return Container(
      width: objectExplorerWidth,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.white,
          width: borderWidth,
        ),
      ),
      child: Column(
        children: [
          _buildAddSceneButton(engine),
          const SizedBox(height: 8),
          _buildSceneList(engine),
          const GameObjectsList()
        ],
      ),
    );
  }

  Widget _buildAddSceneButton(AsciiEngine engine) {
    return EngineButton(
      text: "Add Scene",
      onClick: () {
        var scene = GameScene(name: "New Scene");
        engine.addScene(scene);
      },
    );
  }

  Widget _buildSceneList(AsciiEngine engine) {
    return Expanded(
      child: ListView.builder(
        itemCount: engine.gameScenes.length,
        itemBuilder: (context, index) {
          var scene = engine.gameScenes[index];

          return GestureDetector(
            onTap: () {
              engine.setScene(scene);
            },
            child: ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: GestureDetector(
                onTap: () {
                  engine.setScene(scene);
                },
                child: Text(
                  scene.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              children: [
                ...scene.cells.map((cell) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        "Cell: ${cell.body}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

}