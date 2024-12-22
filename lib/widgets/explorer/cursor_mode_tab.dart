import 'package:engine/utils/globals.dart';
import 'package:engine/core/cursor_mode.dart';
import 'package:engine/core/engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CursorModeTab extends StatefulWidget {
  const CursorModeTab({super.key});

  @override
  State<CursorModeTab> createState() => _CursorModeTabState();
}

class _CursorModeTabState extends State<CursorModeTab> {
  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AsciiEngine>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Container(
        width: 40, height: 140,
        decoration: BoxDecoration(
          color: panelColour,
          border: Border.all(
            color: Colors.white, 
            width: borderWidth
          ),
        ),
        child: Column(
          children: [
            _buildCursorType("Select", engine, Icons.draw, CursorMode.select),
            _buildCursorType("Object", engine, Icons.data_object, CursorMode.object),
          ],
        ),
      ),
    );
  }

  Widget _buildCursorType(String text, AsciiEngine engine, IconData icon, CursorMode mode) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          engine.setCursorMode(mode);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Tooltip(
            message: text,
            child: SizedBox(
              width: 20, height: 20,
              child: Icon(
                icon,
                color: engine.cursorMode == mode ? Colors.white : const Color.fromARGB(255, 173, 173, 173),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}