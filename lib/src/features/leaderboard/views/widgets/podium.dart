// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/leaderboard_model/leaderboard_model.dart';

class PodiumWidget extends StatelessWidget {
  const PodiumWidget({super.key, required this.users, required this.streakData});
  final List<LeaderboardModel> users;
  final bool streakData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PodiumColumn(user: users[1], position: 2, streakData: streakData),
          const SizedBox(width: 8),
          PodiumColumn(user: users[0], position: 1, streakData: streakData),
          const SizedBox(width: 8),
          PodiumColumn(user: users[2], position: 3, streakData: streakData),
        ],
      ),
    );
  }
}

class PodiumColumn extends StatelessWidget {
  final LeaderboardModel user;
  final int position;
  final bool streakData;
  const PodiumColumn({Key? key, required this.user, required this.position, required this.streakData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final bool isWinner = position == 1;
    final double height = position == 1
        ? 150
        : position == 2
        ? 110
        : 90;

    final Color columnColor = position == 1
        ? (isDark ? const Color(0xFF444444) : const Color(0xFFFFE5B4))
        : position == 2
        ? (isDark ? const Color(0xFF333333) : const Color(0xFFBEC8D1))
        : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFD4A574));

    return Expanded(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isWinner ? Colors.amber : Colors.transparent, width: 2),
                ),
                child: CachedNetworkImage(
                  imageUrl: user.user.profilePic,
                  imageBuilder: (context, imageProvider) =>
                      CircleAvatar(radius: isWinner ? 35 : 28, backgroundImage: imageProvider),
                  placeholder: (context, url) => CircleAvatar(
                    radius: isWinner ? 35 : 28,
                    backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(Icons.person, size: isWinner ? 35 : 28, color: isDark ? Colors.grey[600] : Colors.grey[500]),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: isWinner ? 35 : 28,
                    backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(Icons.person, size: isWinner ? 35 : 28, color: isDark ? Colors.grey[600] : Colors.grey[500]),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFFD48F4C), shape: BoxShape.circle),
                child: Text(
                  '$position',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            user.user.name,
            style: TextStyle(color: textColor, fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _scoreChip(context, streakData ? user.currentStreak.toStringAsFixed(0) : user.totalPoints.toStringAsFixed(2)),
          const SizedBox(height: 12),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: columnColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$position',
                style: TextStyle(
                  color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scoreChip(BuildContext context, String score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: context.primaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.primaryColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 10, color: context.isDarkMode ? Colors.white : Colors.black),
          const SizedBox(width: 2),
          Text("$score", style: context.labelLarge),
        ],
      ),
    );
  }
}
