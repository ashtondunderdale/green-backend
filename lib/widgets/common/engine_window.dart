import 'package:engine/utils/globals.dart';
import 'package:engine/widgets/common/engine_button.dart';
import 'package:flutter/material.dart';

class EngineWindow extends StatefulWidget {
  const EngineWindow({super.key, required this.display, required this.width, required this.height, required this.onOkClicked});

  final double width;
  final double height;
  final Widget display;
  final VoidCallback onOkClicked;

  @override
  State<EngineWindow> createState() => _EngineWindowState();
}

class _EngineWindowState extends State<EngineWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: panelColour,
            border: Border.all(
              color: Colors.white,
              width: borderWidth
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _exitButton(),
              Row(
                children: [
                  widget.display,
                ],
              ),

              const Spacer(),
              _okButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _okButton() {
    return EngineButton(
      text: "Ok",
      onClick: () {
        widget.onOkClicked();
        Navigator.pop(context);
      }
    );
  }

  Widget _exitButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.close,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}