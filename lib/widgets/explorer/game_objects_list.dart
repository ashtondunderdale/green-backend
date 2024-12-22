import 'dart:math';

import 'package:engine/utils/globals.dart';
import 'package:engine/core/engine.dart';
import 'package:engine/models/cell_template.dart';
import 'package:engine/widgets/common/engine_button.dart';
import 'package:engine/widgets/common/engine_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameObjectsList extends StatefulWidget {
  const GameObjectsList({super.key});

  @override
  State<GameObjectsList> createState() => _GameObjectsListState();
}

class _GameObjectsListState extends State<GameObjectsList> {
  final objNameController = TextEditingController();
  bool isCreatingObject = false;

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

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
                _addObjectButton(engine),
                if (isCreatingObject) _addObjectNameField(engine)
              ],
            ),

            const SizedBox(height: 8),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  engine.cellTemplates.length,
                  (idx) => _cellTemplateItem(engine, idx),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addObjectButton(AsciiEngine engine) {
    return EngineButton(
      text: "Add Object",
      onClick: () {
        setState(() {
          isCreatingObject = true;
        });
      },
    );
  }

  Widget _cellTemplateItem(AsciiEngine engine, int idx) {
    final obj = engine.cellTemplates[idx];
    final isSelected = (obj == engine.selectedTemplate);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          engine.setSelectedTemplate(obj);
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
                engine.cellTemplates[idx].body,
                style: const TextStyle(
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

  Widget _addObjectNameField(AsciiEngine engine) {
    return EngineTextField(
      width: 30,
      onSubmitted: () {
        setState(() {
          isCreatingObject = false;
        });

        final obj = CellTemplate(
          name: generateRandomString(8),
          body: objNameController.text,
        );

        engine.addTemplate(obj);
      },
      controller: objNameController,
      maxLength: 1,
    );
  }
  
  static String generateRandomString(final int len) {
    return String.fromCharCodes(
      List.generate(len, (index) => Random().nextInt(33) + 89)
    );
  }
}
