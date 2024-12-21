import 'package:engine/models/game_object.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ObjectInspectorPanel extends StatefulWidget {
  const ObjectInspectorPanel({
    super.key, 
    required this.selectedObject
  });

  final GameObject? selectedObject;

  @override
  State<ObjectInspectorPanel> createState() => _ObjectInspectorPanelState();
}

class _ObjectInspectorPanelState extends State<ObjectInspectorPanel> {
  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 200, height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: borderWidth,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.selectedObject?.name ?? ""} ${widget.selectedObject?.body ?? ""}",
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}