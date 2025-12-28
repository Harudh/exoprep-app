import 'dart:ui';
import 'package:flutter/material.dart';

class CreateFlashCardsCollectionWidget extends StatefulWidget {
  final Function(String title, String tag, Color color) onCreate;

  const CreateFlashCardsCollectionWidget({required this.onCreate, super.key});

  @override
  State<CreateFlashCardsCollectionWidget> createState() => _CreateFlashCardsCollectionWidgetState();
}

class _CreateFlashCardsCollectionWidgetState extends State<CreateFlashCardsCollectionWidget> with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  Color _selectedColor = const Color(0xFF6366F1);
  bool _isTitleValid = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Color> _colorPalette = [
    const Color(0xFF6366F1), // Indigo
    const Color(0xFFEC4899), // Pink
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFF10B981), // Emerald
    const Color(0xFFF59E0B), // Amber
    const Color(0xFFEF4444), // Red
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFF84CC16), // Lime
    const Color(0xFFF97316), // Orange
    const Color(0xFF14B8A6), // Teal
    const Color(0xFFA855F7), // Violet
    const Color(0xFF3B82F6), // Blue
  ];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _isTitleValid = _titleController.text.trim().isNotEmpty;
      });
    });

    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    _animController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _tagController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: IntrinsicWidth(
            child: Stack(
              children: [
                // Blurred background - Positioned.fill ensures it matches content size
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark
                                ? [Colors.grey.shade900.withValues(alpha: 0.95), Colors.grey.shade900.withValues(alpha: 0.85)]
                                : [Colors.white.withValues(alpha: 0.95), Colors.white.withValues(alpha: 0.85)],
                          ),
                          border: Border.all(
                            color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(color: _selectedColor.withValues(alpha: 0.2), blurRadius: 60, spreadRadius: 20),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.1),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Content
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Animated header
                          Row(
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.elasticOut,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [_selectedColor, _selectedColor.withValues(alpha: 0.6)]),
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _selectedColor.withValues(alpha: 0.4),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(Icons.auto_stories_rounded, color: Colors.white, size: 28),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create Collection',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.white : Colors.black87,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Build your flashcard set',
                                      style: TextStyle(fontSize: 14, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Title Input
                          _buildGlassInput(
                            controller: _titleController,
                            label: 'Collection Name',
                            hint: 'My awesome flashcards',
                            icon: Icons.edit_rounded,
                            isDark: isDark,
                            autofocus: true,
                          ),

                          const SizedBox(height: 16),

                          // Tag Input
                          _buildGlassInput(
                            controller: _tagController,
                            label: 'Tag (Optional)',
                            hint: 'Science, History, Math...',
                            icon: Icons.label_rounded,
                            isDark: isDark,
                          ),

                          const SizedBox(height: 24),

                          // Color Picker Section
                          Row(
                            children: [
                              Icon(Icons.palette_rounded, size: 20, color: isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                              const SizedBox(width: 8),
                              Text(
                                'Theme Color',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // Compact Color Grid
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _colorPalette.map((color) {
                              final isSelected = _selectedColor == color;

                              return GestureDetector(
                                onTap: () => setState(() => _selectedColor = color),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOutBack,
                                  width: isSelected ? 50 : 44,
                                  height: isSelected ? 50 : 44,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [color, color.withValues(alpha: 0.7)],
                                    ),
                                    shape: BoxShape.circle,
                                    border: isSelected
                                        ? Border.all(color: isDark ? Colors.white : Colors.black, width: 3)
                                        : Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withValues(alpha: isSelected ? 0.5 : 0.3),
                                        blurRadius: isSelected ? 16 : 8,
                                        offset: Offset(0, isSelected ? 6 : 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: AnimatedScale(
                                      scale: isSelected ? 1.0 : 0.0,
                                      duration: const Duration(milliseconds: 200),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                        child: Icon(Icons.check_rounded, color: color, size: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 28),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: _buildButton(
                                  onPressed: () => Navigator.pop(context),
                                  text: 'Cancel',
                                  isPrimary: false,
                                  isDark: isDark,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: _buildButton(
                                  onPressed: _isTitleValid
                                      ? () {
                                          final title = _titleController.text.trim();
                                          final tag = _tagController.text.trim().isEmpty ? 'General' : _tagController.text.trim();
                                          widget.onCreate(title, tag, _selectedColor);
                                          Navigator.pop(context);
                                        }
                                      : null,
                                  text: 'Create Collection',
                                  isPrimary: true,
                                  isDark: isDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    bool autofocus = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.white.withValues(alpha: 0.07), Colors.white.withValues(alpha: 0.03)]
                  : [Colors.black.withValues(alpha: 0.03), Colors.black.withValues(alpha: 0.01)],
            ),
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            autofocus: autofocus,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: isDark ? Colors.grey.shade600 : Colors.grey.shade400),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              prefixIcon: Icon(icon, color: _selectedColor, size: 20),
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({required VoidCallback? onPressed, required String text, required bool isPrimary, required bool isDark}) {
    if (isPrimary) {
      return Container(
        decoration: BoxDecoration(
          gradient: onPressed != null ? LinearGradient(colors: [_selectedColor, _selectedColor.withValues(alpha: 0.7)]) : null,
          color: onPressed == null ? Colors.grey : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: onPressed != null
              ? [BoxShadow(color: _selectedColor.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.3),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300, width: 2),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
