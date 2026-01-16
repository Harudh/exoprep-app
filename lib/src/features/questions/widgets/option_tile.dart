part of '../questions_view.dart';

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.optionLabel,
    required this.isCorrect,
    required this.isSelected,
    required this.isMultipleChoice,
    required this.onTap,
  });

  final String option;
  final String optionLabel;
  final bool isCorrect;
  final bool isSelected;
  final bool isMultipleChoice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final primaryColor = context.colorScheme.primary;
    final borderColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E7EB);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withValues(alpha: isDark ? 0.12 : 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? primaryColor : borderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OptionSelector(
              label: optionLabel,
              isSelected: isSelected,
              isMultipleChoice: isMultipleChoice,
              primaryColor: primaryColor,
              borderColor: borderColor,
              isDark: isDark,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected) ...[const SizedBox(width: 8), Icon(Icons.check_circle, size: 18, color: primaryColor)],
          ],
        ),
      ),
    );
  }
}

class _OptionSelector extends StatelessWidget {
  const _OptionSelector({
    required this.label,
    required this.isSelected,
    required this.isMultipleChoice,
    required this.primaryColor,
    required this.borderColor,
    required this.isDark,
  });

  final String label;
  final bool isSelected;
  final bool isMultipleChoice;
  final Color primaryColor;
  final Color borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (isMultipleChoice) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? primaryColor : borderColor, width: 1.5),
        ),
        child: Center(
          child: isSelected
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                  ),
                ),
        ),
      );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? primaryColor : borderColor, width: 1.5),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: isSelected ? Colors.white : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
          ),
        ),
      ),
    );
  }
}
