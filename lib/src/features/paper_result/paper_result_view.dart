import 'package:root/src/models/question_model/attempted_question_response_model.dart';
import 'package:root/src/models/question_model/question_model.dart';
import 'package:root/src/models/subject_model/subject_model.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

class PaperResultView extends StatefulWidget {
  const PaperResultView({
    super.key,
    required this.paper,
    required this.subjects,
    required this.questions,
    required this.attemptedQuestions,
  });

  final Paper paper;
  final List<Subject> subjects;
  final List<Question> questions;
  final AttemptedQuestionsResponse attemptedQuestions;

  @override
  State<PaperResultView> createState() => _PaperResultViewState();
}

class _PaperResultViewState extends State<PaperResultView> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<double> _fadeAnimation;

  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _unattempted = 0;
  double _percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateResults();
    _mainController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _mainController, curve: Curves.easeOut);
    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  void _calculateResults() {
    int correct = 0;
    int wrong = 0;
    int unattempted = 0;

    for (var attemptedQ in widget.attemptedQuestions.questions) {
      if (attemptedQ.correctAnswer != null) {
        if (attemptedQ.attemptedAnswer == null || attemptedQ.attemptedAnswer!.isEmpty) {
          unattempted++;
        } else if (attemptedQ.attemptedAnswer == attemptedQ.correctAnswer) {
          correct++;
        } else {
          wrong++;
        }
      } else {
        if (attemptedQ.attemptedOptionIndexes == null || attemptedQ.attemptedOptionIndexes!.isEmpty) {
          unattempted++;
        } else {
          final isCorrect = _checkMCQCorrect(attemptedQ.correctOptionIndexes ?? [], attemptedQ.attemptedOptionIndexes ?? []);
          if (isCorrect) {
            correct++;
          } else {
            wrong++;
          }
        }
      }
    }

    _correctAnswers = correct;
    _wrongAnswers = wrong;
    _unattempted = unattempted;
    _percentage = widget.questions.isNotEmpty ? (correct / widget.questions.length) * 100 : 0;
  }

  bool _checkMCQCorrect(List<int> correct, List<int> attempted) {
    if (correct.length != attempted.length) return false;
    final sortedCorrect = [...correct]..sort();
    final sortedAttempted = [...attempted]..sort();
    for (int i = 0; i < sortedCorrect.length; i++) {
      if (sortedCorrect[i] != sortedAttempted[i]) return false;
    }
    return true;
  }

  Color _getScoreColor() {
    if (_percentage >= 75) return const Color(0xFF10B981);
    if (_percentage >= 50) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  String _getGrade() {
    if (_percentage >= 90) return 'A+';
    if (_percentage >= 80) return 'A';
    if (_percentage >= 70) return 'B+';
    if (_percentage >= 60) return 'B';
    if (_percentage >= 50) return 'C';
    return 'F';
  }

  Map<String, Map<String, int>> _calculateSubjectStats() {
    Map<String, Map<String, int>> stats = {};

    for (var subject in widget.subjects) {
      final subjectQuestions = widget.questions.where((q) => q.topic.subject.id == subject.id).toList();
      int correct = 0;
      int wrong = 0;
      int unattempted = 0;

      for (var question in subjectQuestions) {
        final attemptedQ = widget.attemptedQuestions.questions.firstWhere(
          (aq) => aq.questionId == question.id,
          orElse: () => AttemptedQuestion(questionId: ''),
        );

        if (attemptedQ.questionId.isEmpty) {
          unattempted++;
          continue;
        }

        if (attemptedQ.correctAnswer != null) {
          if (attemptedQ.attemptedAnswer == null || attemptedQ.attemptedAnswer!.isEmpty) {
            unattempted++;
          } else if (attemptedQ.attemptedAnswer == attemptedQ.correctAnswer) {
            correct++;
          } else {
            wrong++;
          }
        } else {
          if (attemptedQ.attemptedOptionIndexes == null || attemptedQ.attemptedOptionIndexes!.isEmpty) {
            unattempted++;
          } else {
            final isCorrect = _checkMCQCorrect(attemptedQ.correctOptionIndexes ?? [], attemptedQ.attemptedOptionIndexes ?? []);
            if (isCorrect) {
              correct++;
            } else {
              wrong++;
            }
          }
        }
      }

      stats[subject.id] = {'correct': correct, 'wrong': wrong, 'unattempted': unattempted, 'total': subjectQuestions.length};
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final scoreColor = _getScoreColor();
    final subjectStats = _calculateSubjectStats();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFFAFAFA),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Paper Results',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87),
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Hero Score Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [scoreColor.withValues(alpha: 0.1), scoreColor.withValues(alpha: 0.01)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: scoreColor.withValues(alpha: 0.2), width: 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: _percentage),
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return Text(
                                    value.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 64,
                                      fontWeight: FontWeight.w700,
                                      color: scoreColor,
                                      height: 1,
                                      letterSpacing: -1,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                '%',
                                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600, color: scoreColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: scoreColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Grade ${_getGrade()}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: scoreColor, letterSpacing: 0.5),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TweenAnimationBuilder<int>(
                            tween: IntTween(begin: 0, end: _correctAnswers),
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Text(
                                '$value/${widget.questions.length} Correct',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Stats Grid
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF151515) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _QuickStat(
                                  label: 'Correct',
                                  value: _correctAnswers,
                                  color: const Color(0xFF10B981),
                                  isDark: isDark,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
                              ),
                              Expanded(
                                child: _QuickStat(
                                  label: 'Wrong',
                                  value: _wrongAnswers,
                                  color: const Color(0xFFEF4444),
                                  isDark: isDark,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
                              ),
                              Expanded(
                                child: _QuickStat(label: 'Skipped', value: _unattempted, color: Colors.grey, isDark: isDark),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Subject Performance
                    if (widget.subjects.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF151515) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subject Performance',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...widget.subjects.asMap().entries.map((entry) {
                              final index = entry.key;
                              final subject = entry.value;
                              final stats = subjectStats[subject.id]!;
                              final percentage = stats['total']! > 0 ? (stats['correct']! / stats['total']!) * 100 : 0.0;

                              return Padding(
                                padding: EdgeInsets.only(bottom: index < widget.subjects.length - 1 ? 20 : 0),
                                child: _SubjectItem(
                                  name: subject.name,
                                  correct: stats['correct']!,
                                  total: stats['total']!,
                                  percentage: percentage,
                                  delay: 200 + (index * 100),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),

                    const SizedBox(height: 32),

                    // Paper Info
                    Text(
                      widget.paper.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: isDark ? Colors.white38 : Colors.black38),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({required this.label, required this.value, required this.color, required this.isDark});

  final String label;
  final int value;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: value),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Text(
              '$value',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: color, height: 1),
            );
          },
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isDark ? Colors.white60 : Colors.black45),
        ),
      ],
    );
  }
}

class _SubjectItem extends StatefulWidget {
  const _SubjectItem({
    required this.name,
    required this.correct,
    required this.total,
    required this.percentage,
    required this.delay,
  });

  final String name;
  final int correct;
  final int total;
  final double percentage;
  final int delay;

  @override
  State<_SubjectItem> createState() => _SubjectItemState();
}

class _SubjectItemState extends State<_SubjectItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _animation = Tween<double>(
      begin: 0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87),
              ),
            ),
            Text(
              '${widget.correct}/${widget.total}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? Colors.white60 : Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return FractionallySizedBox(
                  widthFactor: _animation.value,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [AppColors.primaryColor, AppColors.primaryColor.withValues(alpha: 0.6)]),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Text(
              '${(_animation.value * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? Colors.white38 : Colors.black38),
            );
          },
        ),
      ],
    );
  }
}
