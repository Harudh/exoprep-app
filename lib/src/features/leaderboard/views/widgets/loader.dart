import 'package:flutter/material.dart';

class LeaderboardLoadingWidget extends StatefulWidget {
  const LeaderboardLoadingWidget({super.key});

  @override
  State<LeaderboardLoadingWidget> createState() => _LeaderboardLoadingWidgetState();
}

class _LeaderboardLoadingWidgetState extends State<LeaderboardLoadingWidget> with TickerProviderStateMixin {
  late AnimationController _podiumController;
  late AnimationController _medalController;
  late AnimationController _pulseController;

  late Animation<double> _podium1Animation;
  late Animation<double> _podium2Animation;
  late Animation<double> _podium3Animation;
  late Animation<double> _medalBounce;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Podium rising animation
    _podiumController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat();

    _podium1Animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 60),
    ]).animate(_podiumController);

    _podium2Animation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
    ]).animate(_podiumController);

    _podium3Animation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20),
    ]).animate(_podiumController);

    // Medal bounce animation
    _medalController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);

    _medalBounce = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _medalController, curve: Curves.easeInOut));

    // Pulse animation
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _podiumController.dispose();
    _medalController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColorTop = isDark ? const Color(0xFF423D39) : const Color(0xFFF5F2F0);
    final Color bgColorBottom = isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);

    return Scaffold(
      extendBody: true,
      backgroundColor: bgColorBottom,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgColorTop, bgColorBottom],
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_podiumController, _medalController, _pulseController]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: SizedBox(
                    width: 240,
                    height: 280,
                    child: Stack(
                      children: [
                        // Podium blocks
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildAnimatedPodium(2, 90, _podium2Animation.value, isDark),
                              const SizedBox(width: 12),
                              _buildAnimatedPodium(1, 120, _podium1Animation.value, isDark),
                              const SizedBox(width: 12),
                              _buildAnimatedPodium(3, 70, _podium3Animation.value, isDark),
                            ],
                          ),
                        ),
                        // Medals
                        Positioned(
                          bottom: 100 + _medalBounce.value,
                          left: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 60, child: Center(child: _buildMedal(2, const Color(0xFFC0C0C0)))),
                              const SizedBox(width: 12),
                              SizedBox(width: 60, child: Center(child: _buildMedal(1, const Color(0xFFFFD700)))),
                              const SizedBox(width: 12),
                              SizedBox(width: 60, child: Center(child: _buildMedal(3, const Color(0xFFCD7F32)))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedPodium(int rank, double maxHeight, double progress, bool isDark) {
    final currentHeight = maxHeight * progress;

    Color podiumColor;
    if (rank == 1) {
      podiumColor = isDark ? const Color(0xFF444444) : const Color(0xFFFFE5B4);
    } else if (rank == 2) {
      podiumColor = isDark ? const Color(0xFF333333) : const Color(0xFFBEC8D1);
    } else {
      podiumColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFD4A574);
    }

    return Container(
      width: 60,
      height: currentHeight,
      decoration: BoxDecoration(
        color: podiumColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Opacity(
          opacity: progress,
          child: Text(
            '$rank',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedal(int rank, Color color) {
    return Container(
      width: rank == 1 ? 50 : 40,
      height: rank == 1 ? 50 : 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.8), color],
        ),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Center(
        child: Text(
          '$rank',
          style: TextStyle(color: Colors.white, fontSize: rank == 1 ? 24 : 20, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
