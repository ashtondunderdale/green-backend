import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class EngineButton extends StatelessWidget {
  const EngineButton({
    super.key, 
    this.text, 
    required this.onClick, 
    this.icon
  });

  final String? text;
  final IconData? icon;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onClick,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 66, 66, 66),
              border: Border.all(
                color: Colors.white, 
                width: 1
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: icon == null ? Text(
                  text ?? "",
                  style: engineFont(
                    color: Colors.white,
                    fontSize: 12
                  ),
                ) : Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}