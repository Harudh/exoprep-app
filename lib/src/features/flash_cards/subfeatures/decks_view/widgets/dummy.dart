import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlashCardsWaveStyle extends StatefulWidget {
  const FlashCardsWaveStyle({super.key});

  @override
  State<FlashCardsWaveStyle> createState() => _FlashCardsWaveStyleState();
}

class _FlashCardsWaveStyleState extends State<FlashCardsWaveStyle> with TickerProviderStateMixin {
  final List<Map<String, String>> _cards = [
    {'q': 'What is Flutter?', 'a': 'Open-source UI SDK by Google'},
    {'q': 'What is Dart?', 'a': 'Programming language for Flutter'},
    {'q': 'What is a Widget?', 'a': 'Building blocks of Flutter UI'},
    {'q': 'What is State Management?', 'a': 'Handling app state changes'},
    {'q': 'What is Isar?', 'a': 'Fast NoSQL database for Flutter'},
  ];

  int _currentIndex = 0;
  late AnimationController _waveController;
  late AnimationController _transitionController;

  // Vibrant gradients - used for all modes
  final List<List<Color>> _gradients = [
    [const Color(0xFF5B47E5), const Color(0xFF9D50BB)], // Vibrant Purple
    [const Color(0xFFE648D5), const Color(0xFFFF4081)], // Hot Pink
    [const Color(0xFF2196F3), const Color(0xFF00BCD4)], // Electric Blue
    [const Color(0xFF00E676), const Color(0xFF1DE9B6)], // Neon Green
    [const Color(0xFFFF6B6B), const Color(0xFFFFD93D)], // Warm Sunset
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
    if (isNext && _currentIndex < _cards.length - 1) {
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
              // Animated wave background
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return CustomPaint(painter: _WavePainter(animation: _waveController.value));
                  },
                ),
              ),
              Column(
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 32),
                  _buildDotIndicator(),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: _transitionController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1 - (_transitionController.value * 0.1),
                        child: Opacity(
                          opacity: 1 - _transitionController.value,
                          child: _WaveFlipCard(
                            key: ValueKey(_currentIndex),
                            question: _cards[_currentIndex]['q']!,
                            answer: _cards[_currentIndex]['a']!,
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  _buildBottomControls(),
                  const SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
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
              '${_currentIndex + 1} / ${_cards.length}',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.5),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _cards.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: index == _currentIndex ? 32 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: index == _currentIndex ? 1 : 0.4),
            borderRadius: BorderRadius.circular(4),
            boxShadow: index == _currentIndex
                ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(0, 2))]
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleButton(icon: Icons.navigate_before_rounded, onPressed: _currentIndex > 0 ? () => _changeCard(false) : null),
          _CircleButton(
            icon: Icons.navigate_next_rounded,
            onPressed: _currentIndex < _cards.length - 1 ? () => _changeCard(true) : null,
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
  final String question;
  final String answer;

  const _WaveFlipCard({super.key, required this.question, required this.answer});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_showAnswer) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
        setState(() => _showAnswer = !_showAnswer);
      },
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
                    child: _buildFace(widget.answer, false),
                  )
                : _buildFace(widget.question, true),
          );
        },
      ),
    );
  }

  Widget _buildFace(String text, bool isQuestion) {
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
          const SizedBox(height: 40),
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
          const Spacer(),
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

    // Add second wave for more depth
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
