import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial());
}
