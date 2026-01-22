import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:root/src/features/profile/view/widgets/profile_shimmer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
                    imageUrl: 'https://i.pravatar.cc/150?u=tavkeer',
                    width: 104,
                    height: 104,
                    fit: BoxFit.cover,

                    placeholder: (_, __) => const CustomShimmer.circular(size: 104),

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

          Text(
            "Tavkeer",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
          ),

          const Text("Beta Tester", style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}
