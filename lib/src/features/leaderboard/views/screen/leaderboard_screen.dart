import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/features/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:root/src/features/leaderboard/views/screen/leaderboard_view.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LeaderboardCubit(), child: LeaderboardView());
  }
}
