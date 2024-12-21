import 'package:engine/constants/constants.dart';
import 'package:flutter/material.dart';

class EngineWindow extends StatefulWidget {
  const EngineWindow({super.key, required this.display});

  final Widget display;

  @override
  State<EngineWindow> createState() => _EngineWindowState();
}

class _EngineWindowState extends State<EngineWindow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white, width: borderWidth)
      ),
      child: widget.display,
    );
  }
}