import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/profile/cubit/profile_cubit.dart';
import 'package:root/src/features/profile/view/widgets/profile_shimmer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        log('Profile State is :$state');
        final cubit = context.read<ProfileCubit>();
        if (state is ProfileLoadingState) {
          return ProfileHeaderShimmer();
        }
        if (state is ProfileLoadedState) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.amber,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: cubit.user!.profilePic,
                          width: 104,
                          height: 104,
                          fit: BoxFit.cover,

                          placeholder: (_, __) => const CustomShimmerProfile.circular(size: 104),

                          errorWidget: (_, __, ___) => const Icon(Icons.person, size: 48, color: Colors.grey),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                      child: const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Text(cubit.user!.name, style: context.titleLarge),

                Text(
                  cubit.user!.email,
                  style: context.labelMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          );
        }
        return ProfileHeaderShimmer();
      },
    );
  }
}
