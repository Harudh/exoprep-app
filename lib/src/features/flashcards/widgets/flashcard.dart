import 'package:flutter/material.dart';
import 'package:root/data/models/flashcard_model/flashcard_schema_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class FlashcardCard extends StatelessWidget {
  final FlashcardSchemaModel flashcard;
  final VoidCallback onTap;
  final VoidCallback onBookmark;
  final VoidCallback onDelete;

  const FlashcardCard({
    super.key,
    required this.flashcard,
    required this.onTap,
    required this.onBookmark,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(flashcard.tagColor ?? 0xFF3B82F6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flashcard.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (flashcard.subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          flashcard.subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    flashcard.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: flashcard.isBookmarked ? Colors.amber : null,
                  ),
                  onPressed: onBookmark,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              flashcard.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildChip(
                  context,
                  _getTypeIcon(flashcard.type),
                  _getTypeLabel(flashcard.type),
                ),
                const SizedBox(width: 8),
                _buildChip(
                  context,
                  _getSourceIcon(flashcard.source),
                  _getSourceLabel(flashcard.source),
                ),
                const Spacer(),
                Text(
                  timeago.format(flashcard.createdAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            if (flashcard.reviewCount > 0) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Reviewed ${flashcard.reviewCount} times',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, IconData icon, String label) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(FlashcardType type) {
    switch (type) {
      case FlashcardType.shortNotes:
        return Icons.note;
      case FlashcardType.quiz:
        return Icons.quiz;
      case FlashcardType.summary:
        return Icons.summarize;
    }
  }

  String _getTypeLabel(FlashcardType type) {
    switch (type) {
      case FlashcardType.shortNotes:
        return 'Note';
      case FlashcardType.quiz:
        return 'Quiz';
      case FlashcardType.summary:
        return 'Summary';
    }
  }

  IconData _getSourceIcon(FlashcardSource source) {
    switch (source) {
      case FlashcardSource.pdf:
        return Icons.picture_as_pdf;
      case FlashcardSource.image:
        return Icons.image;
      case FlashcardSource.text:
        return Icons.text_fields;
      case FlashcardSource.manual:
        return Icons.edit;
    }
  }

  String _getSourceLabel(FlashcardSource source) {
    switch (source) {
      case FlashcardSource.pdf:
        return 'PDF';
      case FlashcardSource.image:
        return 'Image';
      case FlashcardSource.text:
        return 'Text';
      case FlashcardSource.manual:
        return 'Manual';
    }
  }
}
