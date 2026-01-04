import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';

class FlashCardsWaveStyle extends StatefulWidget {
  final List<FlashCardDataModel> flashCards;

  const FlashCardsWaveStyle({super.key, required this.flashCards});

  @override
  State<FlashCardsWaveStyle> createState() => _FlashCardsWaveStyleState();
}

class _FlashCardsWaveStyleState extends State<FlashCardsWaveStyle> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _transitionController;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  void _changeCard(bool isNext) {
    if (isNext && _currentIndex < widget.flashCards.length - 1) {
      _transitionController.forward().then((_) {
        setState(() => _currentIndex++);
        _transitionController.reverse();
      });
    } else if (!isNext && _currentIndex > 0) {
      _transitionController.forward().then((_) {
        setState(() => _currentIndex--);
        _transitionController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashCards.isEmpty) return const Scaffold(body: Center(child: Text('Empty Deck')));

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(currentIndex: _currentIndex, totalCards: widget.flashCards.length),
            _DotIndicator(currentIndex: _currentIndex, totalCards: widget.flashCards.length),
            const Spacer(),
            AnimatedBuilder(
              animation: _transitionController,
              builder: (context, child) {
                return Opacity(
                  opacity: 1 - _transitionController.value,
                  child: _SimpleFlipCard(key: ValueKey(_currentIndex), flashCard: widget.flashCards[_currentIndex]),
                );
              },
            ),
            const Spacer(),
            _BottomControls(
              currentIndex: _currentIndex,
              totalCards: widget.flashCards.length,
              onPrevious: () => _changeCard(false),
              onNext: () => _changeCard(true),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _SimpleFlipCard extends StatefulWidget {
  final FlashCardDataModel flashCard;

  const _SimpleFlipCard({super.key, required this.flashCard});

  @override
  State<_SimpleFlipCard> createState() => _SimpleFlipCardState();
}

class _SimpleFlipCardState extends State<_SimpleFlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    _showAnswer ? _controller.reverse() : _controller.forward();
    setState(() => _showAnswer = !_showAnswer);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * math.pi;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(angle),
            child: angle > math.pi / 2
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: _CardFace(
                      text: widget.flashCard.answerText ?? '',
                      images: widget.flashCard.answerImages,
                      isQuestion: false,
                    ),
                  )
                : _CardFace(text: widget.flashCard.questionText ?? '', images: widget.flashCard.questionImages, isQuestion: true),
          );
        },
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  final String text;
  final List<String>? images;
  final bool isQuestion;

  const _CardFace({required this.text, this.images, required this.isQuestion});

  bool _isNetworkImage(String path) => path.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      width: 320,
      height: 480,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: textColor.withValues(alpha: 0.08), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            isQuestion ? 'QUESTION' : 'ANSWER',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: textColor.withValues(alpha: 0.3),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textColor, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  if (images != null && images!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: images!.map((path) => _buildImage(path, isDark)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Icon(isQuestion ? Icons.help_outline : Icons.check_circle_outline, color: textColor.withValues(alpha: 0.08), size: 32),
        ],
      ),
    );
  }

  Widget _buildImage(String path, bool isDark) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: _isNetworkImage(path)
            ? Image.network(path, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _errorIcon())
            : Image.file(File(path), fit: BoxFit.cover, errorBuilder: (_, __, ___) => _errorIcon()),
      ),
    );
  }

  Widget _errorIcon() => const Center(child: Icon(Icons.broken_image_outlined, size: 20, color: Colors.grey));
}

/// --- REUSABLE NAVIGATION WIDGETS ---

class _TopBar extends StatelessWidget {
  final int currentIndex;
  final int totalCards;
  const _TopBar({required this.currentIndex, required this.totalCards});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close_rounded, color: textColor, size: 28),
          ),
          Text(
            '${currentIndex + 1} / $totalCards',
            style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.2),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCards;
  const _DotIndicator({required this.currentIndex, required this.totalCards});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalCards,
        (index) => Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? baseColor : baseColor.withValues(alpha: 0.15),
          ),
        ),
      ),
    );
  }
}

class _BottomControls extends StatelessWidget {
  final int currentIndex;
  final int totalCards;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  const _BottomControls({required this.currentIndex, required this.totalCards, required this.onPrevious, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavButton(label: 'PREV', onPressed: currentIndex > 0 ? onPrevious : null, icon: Icons.chevron_left_rounded),
          _NavButton(
            label: 'NEXT',
            onPressed: currentIndex < totalCards - 1 ? onNext : null,
            icon: Icons.chevron_right_rounded,
            isTrailing: true,
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isTrailing;
  const _NavButton({required this.label, this.onPressed, required this.icon, this.isTrailing = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = onPressed == null ? (isDark ? Colors.white10 : Colors.grey[300]) : (isDark ? Colors.white : Colors.black);
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          if (!isTrailing) Icon(icon, size: 24, color: color),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: color, letterSpacing: 1),
          ),
          if (isTrailing) Icon(icon, size: 24, color: color),
        ],
      ),
    );
  }
}
