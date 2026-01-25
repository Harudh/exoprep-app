import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:root/src/models/user_model/user_model.dart';
import 'package:root/src/repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    getUserProfileDeatils();
  }

  final ProfileRepository _profileRepository = ProfileRepository();
  UserModel? user;

  Future<void> getUserProfileDeatils() async {
    emit(ProfileLoadingState());
    try {
      user = await _profileRepository.getUserProfileDeatils();
      emit(ProfileLoadedState());
    } catch (e) {
      print(e);
      emit(ProfileErrorState());
    }
  }
}
