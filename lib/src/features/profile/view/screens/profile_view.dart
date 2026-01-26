import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/features/profile/view/widgets/profile_tile.dart';
import 'package:root/src/features/profile/view/widgets/profile_headers.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(title: "Featured"),
                    const ProfileTile(
                      icon: Icons.workspace_premium,
                      title: "Premium",
                      subtitle: "Unlock offline access and premium features",
                    ),
                    const ProfileTile(
                      icon: Icons.assignment_turned_in,
                      title: "Attempted Papers",
                      subtitle: "Review papers you’ve already attempted",
                    ),
                    const ProfileTile(icon: Icons.insights, title: "Analytics", subtitle: "Track your performance and progress"),

                    const SizedBox(height: 20),
                    _SectionHeader(title: "Settings & Support"),
                    ProfileTile(
                      icon: Icons.palette_outlined,
                      title: "Theme Mode",
                      subtitle: "Switch Light/Dark mode",
                      trailing: ThemeToggleSwitch(),
                    ),
                    const ProfileTile(
                      icon: Icons.help_outline,
                      title: "Raise an Issue",
                      subtitle: "Report bugs or content errors",
                    ),
                    const ProfileTile(
                      icon: Icons.contact_support_outlined,
                      title: "Contact Us",
                      subtitle: "Get in touch with the team",
                    ),

                    const SizedBox(height: 20),
                    _SectionHeader(title: "Legal"),
                    const ProfileTile(icon: Icons.description_outlined, title: "Terms & Conditions"),
                    const ProfileTile(icon: Icons.privacy_tip_outlined, title: "Privacy Policy"),
                    const ProfileTile(icon: Icons.info_outline, title: "About Us"),
                    ProfileTile(
                      icon: Icons.exit_to_app,
                      title: "Log out",
                      isLast: true,
                      ontap: () {
                        FirebaseAuth.instance.signOut();
                        router.go(AppRoute.authentication.path);
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
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
