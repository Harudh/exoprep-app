import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            const ProfileStatsSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: "Academic"),
                  const ProfileTile(icon: Icons.history_edu, title: "My PYQ Downloads", subtitle: "Access offline papers"),
                  const ProfileTile(
                    icon: Icons.analytics_outlined,
                    title: "Quiz Performance",
                    subtitle: "Detailed score analytics",
                  ),

                  const SizedBox(height: 20),
                  _SectionHeader(title: "Settings & Support"),
                  const ProfileTile(icon: Icons.palette_outlined, title: "Theme Mode", subtitle: "Switch Light/Dark mode"),
                  const ProfileTile(icon: Icons.help_outline, title: "Raise an Issue", subtitle: "Report bugs or content errors"),
                  const ProfileTile(
                    icon: Icons.contact_support_outlined,
                    title: "Contact Us",
                    subtitle: "Get in touch with the team",
                  ),

                  const SizedBox(height: 20),
                  _SectionHeader(title: "Legal"),
                  const ProfileTile(icon: Icons.description_outlined, title: "Terms & Conditions"),
                  const ProfileTile(icon: Icons.privacy_tip_outlined, title: "Privacy Policy"),
                  const ProfileTile(icon: Icons.info_outline, title: "About Us", isLast: true),

                  const SizedBox(height: 40), // Space for Bottom Nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF423D39), const Color(0xFF0F0F0F)]
              : [const Color(0xFFE2E8F0), const Color(0xFFF8F9FA)],
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.amber,
                child: CircleAvatar(radius: 52, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=tavkeer')),
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
            "Tavkeer", //
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
          ),
          const Text("Beta Tester", style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _StatItem(label: "Solved", value: "124"),
          _StatItem(label: "Rank", value: "#12"),
          _StatItem(label: "Streak", value: "6 Days"),
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isLast;

  const ProfileTile({super.key, required this.icon, required this.title, this.subtitle, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: isDark ? Colors.white70 : Colors.black87, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: Colors.grey)) : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: () {},
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: isDark ? Colors.white38 : Colors.black38,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
