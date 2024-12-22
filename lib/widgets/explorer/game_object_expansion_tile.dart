import 'package:flutter/material.dart';

import '../../utils/globals.dart';

class GameObjectExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onTap;
  final bool isSelected;

  const GameObjectExpansionTile({
    super.key, 
    required this.title,
    required this.children,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  State<GameObjectExpansionTile> createState() => _GameObjectExpansionTileState();
}

class _GameObjectExpansionTileState extends State<GameObjectExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpansionTile(),
        _buildListItems()
      ],
    );
  }

  Widget _buildExpansionTile() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            color: widget.isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: engineFont(
                    color: Colors.white,
                    fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItems() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _isExpanded ? null : 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var x in widget.children)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: x
            )
        ],
      ),
    );
  }
}
