import 'package:engine/utils/globals.dart';
import 'package:engine/core/cursor/cursor_mode.dart';
import 'package:engine/core/engine.dart';
import 'package:flutter/material.dart';

class CursorModeTab extends StatefulWidget {
  const CursorModeTab({super.key, required this.engine});

  final AsciiEngine engine;

  @override
  State<CursorModeTab> createState() => _CursorModeTabState();
}

class _CursorModeTabState extends State<CursorModeTab> {
  @override
  Widget build(BuildContext context) {
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
            _buildCursorType("Select", Icons.draw, CursorMode.select),
            _buildCursorType("Object", Icons.data_object, CursorMode.object),
            _buildCursorType("Remove", Icons.delete, CursorMode.delete),
          ],
        ),
      ),
    );
  }

  Widget _buildCursorType(String text, IconData icon, CursorMode mode) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.engine.setCursorMode(mode);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Tooltip(
            message: text,
            child: SizedBox(
              width: 20, height: 20,
              child: Icon(
                icon,
                color: widget.engine.cursorMode == mode ? Colors.white : const Color.fromARGB(255, 173, 173, 173),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}