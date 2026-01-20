import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/features/profile/cubit/profile_cubit.dart';
import 'package:root/src/features/profile/view/screens/profile_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ProfileCubit(), child: ProfileView());
  }
}
