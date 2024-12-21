import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';

class EngineTextField extends StatefulWidget {
  const EngineTextField({super.key, required this.onSubmitted, required this.controller, this.maxLength});

  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final int? maxLength;

  @override
  State<EngineTextField> createState() => _EngineTextFieldState();
}

class _EngineTextFieldState extends State<EngineTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: borderWidth,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        textAlignVertical: TextAlignVertical.center,
        maxLengthEnforcement: widget.maxLength == null ? null : MaxLengthEnforcement.enforced,
        inputFormatters: widget.maxLength == null ? null : [
          LengthLimitingTextInputFormatter(1),
        ],
        onSubmitted: (_) {
          widget.onSubmitted();
        },
      ),
    );
  }
}