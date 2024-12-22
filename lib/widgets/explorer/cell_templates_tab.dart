import 'package:engine/utils/globals.dart';
import 'package:engine/core/engine.dart';
import 'package:engine/models/cell_template.dart';
import 'package:engine/widgets/common/engine_button.dart';
import 'package:engine/widgets/common/engine_text_field.dart';
import 'package:engine/widgets/common/engine_window.dart';
import 'package:flutter/material.dart';

class GameObjectsList extends StatefulWidget {
  const GameObjectsList({super.key, required this.engine});

  final AsciiEngine engine;

  @override
  State<GameObjectsList> createState() => _GameObjectsListState();
}

class _GameObjectsListState extends State<GameObjectsList> {
  final templateNameController = TextEditingController();
  final templateBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Container(
        width: 260,
        height: 140,
        decoration: BoxDecoration(
          color: panelColour,
          border: Border.all(
            color: Colors.white,
            width: borderWidth,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _addCellTemplateButton(),
              ],
            ),

            const SizedBox(height: 8),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  widget.engine.cellTemplates.length,
                  (idx) => _cellTemplateItem(idx),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addCellTemplateButton() {
    return EngineButton(
      text: "Add Template",
      onClick: () {
        showDialog(context: context, builder: (context) {
          return EngineWindow(
            width: 400,
            height: 140,
            onOkClicked: () {
              final template = CellTemplate(
                body: templateBodyController.text,
                name: templateNameController.text
              );

              widget.engine.addTemplate(template);
              Navigator.pop(context);
            },
            display: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: EngineTextField(
                    hintText: "template name",
                    controller: templateNameController,
                    width: 240
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: EngineTextField(
                    hintText: "body",
                    controller: templateBodyController,
                    maxLength: 1,
                    width: 54
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _cellTemplateItem(int idx) {
    final obj = widget.engine.cellTemplates[idx];
    final isSelected = (obj == widget.engine.selectedTemplate);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.engine.setSelectedTemplate(obj);
          widget.engine.setSelectedObject(obj);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.white : const Color.fromARGB(255, 108, 108, 108),
                width: borderWidth
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                widget.engine.cellTemplates[idx].body,
                style: engineFont(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
