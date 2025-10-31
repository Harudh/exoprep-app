import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class ColorPickerPanel extends StatefulWidget {
  final int? selectedColorValue;
  final ValueChanged<int> onColorSelected;

  const ColorPickerPanel({
    required this.onColorSelected,
    this.selectedColorValue,
    super.key,
  });

  @override
  State<ColorPickerPanel> createState() => _ColorPickerPanelState();
}

class _ColorPickerPanelState extends State<ColorPickerPanel> {
  late int selectedColorValue;

  static const List<int> colorValues = [
    0xFFFF6B6B,
    0xFFFF8C42,
    0xFFFFA726,
    0xFF9CCC65,
    0xFF66BB6A,
    0xFF34C759,
    0xFF26A69A,
    0xFF29B6F6,
    0xFF42A5F5,
    0xFF5C6BC0,
    0xFF7E57C2,
    0xFF9C27B0,
    0xFFAB47BC,
    0xFFEC407A,
    0xFFEF5350,
    0xFFE57373,
  ];

  @override
  void initState() {
    super.initState();
    selectedColorValue = widget.selectedColorValue ?? 0xFF42A5F5;
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) return 10;
    if (width > 400) return 8;
    return 6;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xFF3A3A3A)
            : Colors.grey.shade100,

        borderRadius: BorderRadius.circular(16),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: colorValues.length,
        itemBuilder: (context, index) {
          final colorValue = colorValues[index];
          final isSelected = colorValue == selectedColorValue;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColorValue = colorValue;
              });
              widget.onColorSelected(colorValue);
            },
            child: ColorCircle(
              color: Color(colorValue),
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorCircle({
    required this.color,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 28,
            )
          : null,
    );
  }
}
