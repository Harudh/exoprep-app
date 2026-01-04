import 'dart:io';
import 'package:flutter/material.dart';

class CreateCardTile extends StatelessWidget {
  final int index;
  final TextEditingController questionController;
  final TextEditingController answerController;
  final List<File> questionImages;
  final List<File> answerImages;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(bool isQuestion) onAddImage;

  const CreateCardTile({
    super.key,
    required this.index,
    required this.questionController,
    required this.answerController,
    required this.questionImages,
    required this.answerImages,
    required this.isExpanded,
    required this.onToggle,
    required this.onDelete,
    required this.onAddImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isExpanded ? baseColor : baseColor.withValues(alpha: 0.1), width: 1.5),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onToggle,
            leading: CircleAvatar(
              radius: 12,
              backgroundColor: baseColor,
              child: Text(
                '${index + 1}',
                style: TextStyle(color: isDark ? Colors.black : Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              questionController.text.isEmpty ? "New Flashcard" : questionController.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: baseColor),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: Colors.red.withValues(alpha: 0.7), size: 20),
              onPressed: onDelete,
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _SkeletalInput(
                    label: "QUESTION",
                    controller: questionController,
                    images: questionImages,
                    onAddImage: () => onAddImage(true),
                  ),
                  const SizedBox(height: 20),
                  _SkeletalInput(
                    label: "ANSWER",
                    controller: answerController,
                    images: answerImages,
                    onAddImage: () => onAddImage(false),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SkeletalInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<File> images;
  final VoidCallback onAddImage;

  const _SkeletalInput({required this.label, required this.controller, required this.images, required this.onAddImage});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: textColor.withValues(alpha: 0.4),
                letterSpacing: 1.5,
              ),
            ),
            GestureDetector(
              onTap: onAddImage,
              child: Icon(Icons.add_a_photo_outlined, size: 18, color: textColor.withValues(alpha: 0.6)),
            ),
          ],
        ),
        if (images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, i) => Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: textColor.withValues(alpha: 0.1)),
                    image: DecorationImage(image: FileImage(images[i]), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        TextField(
          controller: controller,
          maxLines: null,
          style: TextStyle(color: textColor, fontSize: 15),
          decoration: InputDecoration(
            hintText: "Enter content...",
            hintStyle: TextStyle(color: textColor.withValues(alpha: 0.2)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: textColor.withValues(alpha: 0.1))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
          ),
        ),
      ],
    );
  }
}
