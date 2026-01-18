import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.icon, this.iconSize, this.containerSize});

  final IconData icon;
  final double? iconSize;
  final double? containerSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: containerSize ?? 44,
        width: containerSize ?? 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
          border: Border.all(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
        ),
        child: Icon(icon, size: iconSize ?? 22),
      ),
    );
  }
}
