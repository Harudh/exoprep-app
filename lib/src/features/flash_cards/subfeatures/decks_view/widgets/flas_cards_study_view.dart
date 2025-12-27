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
  late AnimationController _waveController;
  late AnimationController _transitionController;

  final List<List<Color>> _gradients = [
    [const Color(0xFF5B47E5), const Color(0xFF9D50BB)],
    [const Color(0xFFE648D5), const Color(0xFFFF4081)],
    [const Color(0xFF2196F3), const Color(0xFF00BCD4)],
    [const Color(0xFF00E676), const Color(0xFF1DE9B6)],
    [const Color(0xFFFF6B6B), const Color(0xFFFFD93D)],
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
    _transitionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _waveController.dispose();
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
    if (widget.flashCards.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No flashcards available', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
        ),
      );
    }

    final currentGradient = _gradients[_currentIndex % _gradients.length];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: currentGradient),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) => CustomPaint(painter: _WavePainter(animation: _waveController.value)),
                ),
              ),
              Column(
                children: [
                  _TopBar(currentIndex: _currentIndex, totalCards: widget.flashCards.length),
                  const SizedBox(height: 32),
                  _DotIndicator(currentIndex: _currentIndex, totalCards: widget.flashCards.length),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: _transitionController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1 - (_transitionController.value * 0.1),
                        child: Opacity(
                          opacity: 1 - _transitionController.value,
                          child: _WaveFlipCard(key: ValueKey(_currentIndex), flashCard: widget.flashCards[_currentIndex]),
                        ),
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
                  const SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final int currentIndex;
  final int totalCards;

  const _TopBar({required this.currentIndex, required this.totalCards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
            ),
            child: Text(
              '${currentIndex + 1} / $totalCards',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.5),
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalCards,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: index == currentIndex ? 32 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: index == currentIndex ? 1 : 0.4),
            borderRadius: BorderRadius.circular(4),
            boxShadow: index == currentIndex
                ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(0, 2))]
                : null,
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(icon: Icons.navigate_before_rounded, onPressed: currentIndex > 0 ? onPrevious : null),
          _CircleButton(
            icon: Icons.navigate_next_rounded,
            onPressed: currentIndex < totalCards - 1 ? onNext : null,
            isLarge: true,
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLarge;

  const _CircleButton({required this.icon, this.onPressed, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    final size = isLarge ? 64.0 : 48.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: onPressed != null ? 0.3 : 0.1),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
        boxShadow: onPressed != null
            ? [BoxShadow(color: Colors.white.withValues(alpha: 0.2), blurRadius: 12, offset: const Offset(0, 4))]
            : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: isLarge ? 32 : 24),
      ),
    );
  }
}

class _WaveFlipCard extends StatefulWidget {
  final FlashCardDataModel flashCard;

  const _WaveFlipCard({super.key, required this.flashCard});

  @override
  State<_WaveFlipCard> createState() => _WaveFlipCardState();
}

class _WaveFlipCardState extends State<_WaveFlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_showAnswer) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
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
          final showBack = angle > math.pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: showBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: _CardFace(
                      text: widget.flashCard.answerText ?? 'No answer',
                      images: widget.flashCard.answerImages,
                      isQuestion: false,
                    ),
                  )
                : _CardFace(
                    text: widget.flashCard.questionText ?? 'No question',
                    images: widget.flashCard.questionImages,
                    isQuestion: true,
                  ),
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

  bool _isNetworkImage(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 460,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 40, offset: const Offset(0, 20)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -10)),
        ],
      ),
      padding: const EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
            ),
            child: Icon(isQuestion ? Icons.psychology_rounded : Icons.lightbulb_rounded, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.4,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (images != null && images!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: images!.map((imagePath) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _isNetworkImage(imagePath)
                              ? Image.network(
                                  imagePath,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.white.withValues(alpha: 0.2),
                                      child: const Icon(Icons.image_not_supported, color: Colors.white),
                                    );
                                  },
                                )
                              : Image.file(
                                  File(imagePath),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.white.withValues(alpha: 0.2),
                                      child: const Icon(Icons.image_not_supported, color: Colors.white),
                                    );
                                  },
                                ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.touch_app_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  isQuestion ? 'TAP TO REVEAL' : 'TAP TO HIDE',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animation;

  _WavePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final path = Path();
    const waveHeight = 30.0;
    final waveLength = size.width / 2;

    path.moveTo(0, size.height * 0.7);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.7 + math.sin((x / waveLength * 2 * math.pi) + (animation * 2 * math.pi)) * waveHeight;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.8);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.8 + math.sin((x / waveLength * 2 * math.pi) - (animation * 2 * math.pi)) * waveHeight * 0.7;
      path2.lineTo(x, y);
    }

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) => true;
}
