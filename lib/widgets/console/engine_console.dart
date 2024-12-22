import 'package:engine/core/engine.dart';
import 'package:engine/utils/globals.dart';
import 'package:engine/widgets/common/engine_text_field.dart';
import 'package:flutter/material.dart';

class EngineConsole extends StatefulWidget {
  const EngineConsole({super.key, required this.engine});

  final AsciiEngine engine;

  @override
  State<EngineConsole> createState() => _EngineConsoleState();
}

class _EngineConsoleState extends State<EngineConsole> {
  final commandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: consoleHeight,
      decoration: const BoxDecoration(
        color: panelColour,
        border: Border(
          top: BorderSide(
            color: Colors.white, 
            width: borderWidth
          )
        )
      ),
      child: EngineTextField(
        hasBorder: false,
        width: double.infinity,
        onSubmitted: () {
          final text = commandController.text;

          if (text == "setMode game") {
            widget.engine.setGameMode(true);
          } 
          else if (text == "setMode editor") {
            widget.engine.setGameMode(false);
          }

          commandController.clear();
        }, 
        controller: commandController
      )
    );
  }
}