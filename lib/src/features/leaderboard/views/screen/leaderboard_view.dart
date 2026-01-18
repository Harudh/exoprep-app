import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/theme/colors.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> users = [
    {"rank": 1, "name": "lilyonetw...", "score": 146, "img": "https://i.pravatar.cc/150?u=a"},
    {"rank": 2, "name": "josheleve...", "score": 105, "img": "https://i.pravatar.cc/150?u=b"},
    {"rank": 3, "name": "herotaylo...", "score": 99, "img": "https://i.pravatar.cc/150?u=c"},
    {"rank": 4, "name": "whitefish664", "score": 96, "img": "https://i.pravatar.cc/150?u=d"},
    {"rank": 5, "name": "sadpanda176", "score": 88, "img": "https://i.pravatar.cc/150?u=e"},
    {"rank": 6, "name": "silverduck204", "score": 87, "img": "https://i.pravatar.cc/150?u=f"},
    {"rank": 7, "name": "beautifulmouse112", "score": 85, "img": "https://i.pravatar.cc/150?u=g"},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Adaptive Colors
    final Color bgColorTop = isDark ? const Color(0xFF423D39) : const Color(0xFFF5F2F0);
    final Color bgColorBottom = isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);
    final Color listBgColor = isDark ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor;
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      extendBody: true,
      backgroundColor: bgColorBottom,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgColorTop, bgColorBottom],
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(textColor, isDark),
              const SizedBox(height: 20),
              _buildTabs(isDark),
              const SizedBox(height: 30),
              _buildPodium(isDark, textColor),
              Expanded(child: _buildRankList(listBgColor, textColor, isDark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Leaderboard",
        style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [_tabItem("Global", 0, isDark), _tabItem("Streaks", 1, isDark)]),
    );
  }

  Widget _tabItem(String label, int index, bool isDark) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? (isDark ? Colors.white : Colors.black87) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? (isDark ? Colors.black : Colors.white) : (isDark ? Colors.white60 : Colors.black54),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPodium(bool isDark, Color textColor) {
    // Column colors change slightly for light mode to maintain depth
    final Color silver = isDark ? const Color(0xFF333333) : const Color(0xFFBEC8D1);
    final Color gold = isDark ? const Color(0xFF444444) : const Color(0xFFFFE5B4);
    final Color bronze = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFD4A574);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _podiumColumn(users[1], "2", 110, silver, textColor, isDark),
          const SizedBox(width: 8),
          _podiumColumn(users[0], "1", 150, gold, textColor, isDark, isWinner: true),
          const SizedBox(width: 8),
          _podiumColumn(users[2], "3", 90, bronze, textColor, isDark),
        ],
      ),
    );
  }

  Widget _podiumColumn(
    Map<String, dynamic> user,
    String rank,
    double height,
    Color color,
    Color textColor,
    bool isDark, {
    bool isWinner = false,
  }) {
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
                child: CircleAvatar(radius: isWinner ? 35 : 28, backgroundImage: NetworkImage(user['img'])),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFFD48F4C), shape: BoxShape.circle),
                child: Text(
                  rank,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            user['name'],
            style: TextStyle(color: textColor, fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _scoreChip(user['score']),
          const SizedBox(height: 12),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: color,
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
                rank,
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

  Widget _scoreChip(int score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF7B51D3).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF7B51D3).withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, size: 10, color: Colors.purpleAccent),
          const SizedBox(width: 2),
          Text("$score", style: context.labelLarge),
        ],
      ),
    );
  }

  Widget _buildRankList(Color listBgColor, Color textColor, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: listBgColor,
        border: Border(top: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300, width: 1)),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 110),
          itemCount: users.length - 3,
          separatorBuilder: (_, __) => Divider(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05), height: 30),
          itemBuilder: (context, index) {
            final user = users[index + 3];
            return Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    "${user['rank']}",
                    style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(radius: 18, backgroundImage: NetworkImage(user['img'])),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    user['name'],
                    style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
                _scoreChip(user['score']),
              ],
            );
          },
        ),
      ),
    );
  }
}
