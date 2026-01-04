import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';

class FlashCardTile extends StatelessWidget {
  const FlashCardTile({super.key, required this.card, required this.onDelete});

  final FlashCardDataModel card;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          card.questionText ?? 'No question',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: card.answerText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(card.answerText!, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.bodyMedium),
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete Card'),
                content: const Text('Are you sure you want to delete this card?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      onDelete();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
