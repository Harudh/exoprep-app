import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isLast;
  final void Function()? ontap;
  final Widget? trailing;

  const ProfileTile({
    super.key,
    required this.icon,
    this.trailing,
    required this.title,
    this.subtitle,
    this.isLast = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
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
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: ontap,
      ),
    );
  }
}
