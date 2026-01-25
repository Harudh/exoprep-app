import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/leaderboard/views/widgets/loader.dart';
import 'package:root/src/features/leaderboard/views/widgets/podium.dart';
import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/features/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:root/src/features/leaderboard/views/widgets/empty_widget.dart';
import 'package:root/src/features/leaderboard/views/widgets/exam_selector.dart';
import 'package:root/src/features/leaderboard/views/widgets/leaderboard_list.dart';
import 'package:root/src/features/leaderboard/views/widgets/try_again_widget.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaderboardCubit, LeaderboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<LeaderboardCubit>();
        if (state is LeaderboardLoadingState) {
          return LeaderboardLoadingWidget();
        }
        if (state is LeaderboardDataSuccessState) {
          return Scaffold(
            extendBody: true,
            body: BackgroundGradient(
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    ExamSelector(),
                    const SizedBox(height: 20),
                    if (cubit.streaksLeaderboard.isEmpty) ...[LeaderboardEmptyWidget()],
                    if (cubit.streaksLeaderboard.isNotEmpty) ...[
                      _buildTabs(),
                      const SizedBox(height: 30),
                      ValueListenableBuilder(
                        valueListenable: selectedIndex,
                        builder: (context, value, child) {
                          return PodiumWidget(
                            users: value == 0 ? cubit.scoreLeaderboard : cubit.streaksLeaderboard,
                            streakData: value == 1,
                          );
                        },
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: selectedIndex,
                          builder: (context, value, child) {
                            return RankListWidget(
                              users: value == 0 ? cubit.scoreLeaderboard : cubit.streaksLeaderboard,
                              isStreakMode: value == 1,
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }
        if (state is ErrorState) {
          return TryAgainWidget(onRetry: () => cubit.getInitialData(), message: 'Please try again');
        }
        return LeaderboardEmptyWidget();
      },
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: (context.isDarkMode ? Colors.white : Colors.black).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [_tabItem("Score", 0), _tabItem("Streaks", 1)]),
    );
  }

  Widget _tabItem(String label, int index) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        bool isSelected = selectedIndex.value == index;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              selectedIndex.value = index;
              context.read<LeaderboardCubit>().showLoadingDelay();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? (context.isDarkMode ? Colors.white : Colors.black87) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? (context.isDarkMode ? Colors.black : Colors.white)
                      : (context.isDarkMode ? Colors.white60 : Colors.black54),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
