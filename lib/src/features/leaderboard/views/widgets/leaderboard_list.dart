import 'package:flutter/material.dart';
import 'package:root/src/core/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/models/leaderboard_model/leaderboard_model.dart';

class RankListWidget extends StatelessWidget {
  final List<LeaderboardModel> users;
  final bool isStreakMode;

  const RankListWidget({super.key, required this.users, this.isStreakMode = false});

  List<LeaderboardModel> get _displayUsers {
    // Skip top 3 users (they're in the podium)
    final List<LeaderboardModel> remaining = users.length > 3 ? users.sublist(3) : [];

    // If less than 7 total items (to show at least 4 in list after podium), add mock data
    if (remaining.length < 7) {
      final int needed = 7 - remaining.length;
      final List<LeaderboardModel> mockUsers = List.generate(
        needed,
        (index) => _generateMockUser(remaining.length + index + 4), // Start rank after existing users
      );
      return [...remaining, ...mockUsers];
    }

    return remaining;
  }

  LeaderboardModel _generateMockUser(int rank) {
    final List<String> mockNames = [
      'silverbird${rank}',
      'goldenfish${rank}',
      'panda${rank}',
      'tiger${rank}',
      'greenwolf${rank}',
      'piyal${rank}',
      'riya${rank}',
    ];

    final List<String> mockImages = ['https://i.pravatar.cc/150?u=mock$rank', 'https://i.pravatar.cc/150?img=$rank'];

    return LeaderboardModel(
      rank: rank,
      user: LeaderboardUser(
        id: 'mock_$rank',
        name: mockNames[rank % mockNames.length],
        email: 'user$rank@example.com',
        profilePic: mockImages[rank % mockImages.length],
      ),
      currentStreak: 1,
      longestStreak: 1,
      totalPoints: 1,
      avgScore: 1,
      totalAttempts: 10 - rank,
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayUsers = _displayUsers;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor,
        border: Border(top: BorderSide(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300, width: 1)),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDarkMode ? 0.4 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 110),
          itemCount: displayUsers.length,
          separatorBuilder: (_, __) =>
              Divider(color: (context.isDarkMode ? Colors.white : Colors.black).withValues(alpha: 0.05), height: 30),
          itemBuilder: (context, index) {
            final user = displayUsers[index];
            final score = isStreakMode ? user.currentStreak : user.totalPoints.toInt();

            return Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    "${user.rank}",
                    style: TextStyle(color: context.isDarkMode ? Colors.white54 : Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                CachedNetworkImage(
                  imageUrl: user.user.profilePic,
                  imageBuilder: (context, imageProvider) => CircleAvatar(radius: 18, backgroundImage: imageProvider),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 18,
                    backgroundColor: context.isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(Icons.person, size: 18, color: context.isDarkMode ? Colors.grey[600] : Colors.grey[500]),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 18,
                    backgroundColor: context.isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(Icons.person, size: 18, color: context.isDarkMode ? Colors.grey[600] : Colors.grey[500]),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    user.user.name,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ScoreChipWidget(score: score),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ScoreChipWidget extends StatelessWidget {
  final int score;

  const ScoreChipWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
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
          const Icon(Icons.add, size: 10),
          const SizedBox(width: 2),
          Text("$score", style: context.labelLarge),
        ],
      ),
    );
  }
}
