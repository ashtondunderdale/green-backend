import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/globals.dart';

class EngineTextField extends StatefulWidget {
  const EngineTextField({
    super.key, 
    this.onSubmitted, 
    required this.controller, 
    this.maxLength, 
    required this.width,
    this.hasBorder = true
  });

  final TextEditingController controller;
  final VoidCallback? onSubmitted;
  final int? maxLength;
  final double width;
  final bool hasBorder;

  @override
  State<EngineTextField> createState() => _EngineTextFieldState();
}

class _EngineTextFieldState extends State<EngineTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 30,
      decoration: BoxDecoration(
        border: widget.hasBorder ? Border.all(
          color: Colors.white,
          width: borderWidth,
        ) : null,
      ),
      child: TextField(
        controller: widget.controller,
        cursorColor: Colors.grey,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        maxLengthEnforcement: widget.maxLength == null ? null : MaxLengthEnforcement.enforced,
        inputFormatters: widget.maxLength == null ? null : [LengthLimitingTextInputFormatter(widget.maxLength)],
        onSubmitted: (_) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!();
          }
        },
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 6),
          border: InputBorder.none,
          counterText: '',
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
