import 'package:engine/widgets/common/engine_text_field.dart';
import 'package:engine/widgets/common/engine_window.dart';
import 'package:engine/widgets/explorer/cursor_mode_tab.dart';
import 'package:engine/widgets/explorer/game_objects_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:engine/models/scene.dart';
import 'package:engine/widgets/common/engine_button.dart';

import '../../utils/globals.dart';
import '../../core/engine.dart';
import 'game_object_expansion_tile.dart';

class ObjectExplorerPanel extends StatefulWidget {
  const ObjectExplorerPanel({super.key});

  @override
  State<ObjectExplorerPanel> createState() => _ObjectExplorerPanelState();
}

class _ObjectExplorerPanelState extends State<ObjectExplorerPanel> {
  final createSceneNameController = TextEditingController();
  String createSceneError = "";

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    return Container(
      width: objectExplorerWidth,
      decoration: const BoxDecoration(
        color: panelColour,
        border: Border(
          right: BorderSide(
            color: Colors.white,
            width: borderWidth,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddSceneButton(engine),
          const SizedBox(height: 8),
          _buildSceneList(engine),
          
          const Row(
            children: [
              GameObjectsList(),
              CursorModeTab(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddSceneButton(AsciiEngine engine) {
    return EngineButton(
      text: "New Scene",
      onClick: () {
        showDialog(
          context: context,
          builder: (context) {
            return EngineWindow(
              onOkClicked: () {
                if (createSceneNameController.text.isEmpty) {
                  setState(() {
                    createSceneError = "Invalid scene name";
                  });

                  return;
                }

                var scene = GameScene(name: createSceneNameController.text);
                engine.addScene(scene);

                createSceneNameController.clear();
              },
              width: 320,
              height: 180,
              display: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EngineTextField(
                      width: 160,
                      controller: createSceneNameController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        createSceneError,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSceneList(AsciiEngine engine) {
    return Expanded(
      child: ListView.builder(
        itemCount: engine.gameScenes.length,
        itemBuilder: (context, index) {
          final scene = engine.gameScenes[index];
          return GameObjectExpansionTile(
            title: scene.name,
            isSelected: engine.activeScene == scene,
            onTap: () {
              engine.setScene(scene);
              engine.setSelectedObject(scene);
            },
            children: scene.cells.map((cell) {
              return GestureDetector(
                onTap: () {
                  engine.setSelectedObject(cell);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    cell.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: engine.selectedObject == cell ? FontWeight.bold : null
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}