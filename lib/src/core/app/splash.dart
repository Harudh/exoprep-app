import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/constants/strings.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/navigation/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final AnimationController _dotsController;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _dotsController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();

    _scaleController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await tokenPrint();
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      final user = await context.authViewModel.getCurrentUser();
      if (!mounted) return;
      context.go(user != null ? AppRoute.home.path : AppRoute.authentication.path);
    });
  }

  Future<void> tokenPrint() async {
    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdToken();
    log("Access Token: $idToken");
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade800;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/logo.png', height: 40, ),
                      SizedBox(width: 12),
                      Text(
                        AppStrings.appName,
                        style: context.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedBuilder(
                animation: _dotsController,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      final delay = index * 0.2;
                      final value = (_dotsController.value - delay) % 1.0;
                      final bounce = (value < 0.5 ? value : 1 - value) * 2;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Transform.scale(
                          scale: 0.6 + bounce * 0.4,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(color: primaryColor.withValues(alpha: 0.8), shape: BoxShape.circle),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
