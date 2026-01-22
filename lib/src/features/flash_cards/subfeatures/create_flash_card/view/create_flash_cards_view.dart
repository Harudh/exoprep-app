import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root/src/core/common/ui/widgets/circle_button.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/core/utils/file_helper.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';

import '../widgets/create_card_tile.dart';

class CreateFlashCardView extends StatefulWidget {
  final String deckId;
  final String deckName;
  final void Function(List<FlashCardDataModel> cards) onSave;

  const CreateFlashCardView({super.key, required this.deckId, required this.deckName, required this.onSave});

  @override
  State<CreateFlashCardView> createState() => _CreateFlashCardViewState();
}

class _CreateFlashCardViewState extends State<CreateFlashCardView> {
  final List<CardEntry> _entries = [CardEntry()];
  int? _expandedIndex = 0;
  bool _isSaving = false;

  Future<void> _handleSave() async {
    // 1. Validate
    if (_entries.any((e) => !e.isValid)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Complete all cards before saving")));
      return;
    }

    setState(() => _isSaving = true);

    try {
      List<FlashCardDataModel> finalizedCards = [];

      for (int i = 0; i < _entries.length; i++) {
        final entry = _entries[i];

        // 2. Persist images (Move from tmp to documents)
        final qImages = await Future.wait(entry.questionImages.map((f) => FlashCardFileHelper.persistImage(f.path)));
        final aImages = await Future.wait(entry.answerImages.map((f) => FlashCardFileHelper.persistImage(f.path)));

        finalizedCards.add(
          FlashCardDataModel(
            deckId: widget.deckId,
            questionText: entry.questionController.text,
            answerText: entry.answerController.text,
            questionImages: qImages,
            answerImages: aImages,
            orderIndex: i,
          ),
        );
      }

      widget.onSave(finalizedCards);
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _addImage(int index, bool isQuestion) async {
    final images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        final files = images.map((e) => File(e.path)).toList();
        isQuestion ? _entries[index].questionImages.addAll(files) : _entries[index].answerImages.addAll(files);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.deckName, style: context.titleLarge),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Center(
            child: CircleButton(icon: Icons.close, ontap: () => router.pop()),
          ),
        ),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Center(
                child: CircleButton(icon: Icons.done, ontap: _handleSave),
              ),
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        itemCount: _entries.length,
        itemBuilder: (context, index) => CreateCardTile(
          index: index,
          questionController: _entries[index].questionController,
          answerController: _entries[index].answerController,
          questionImages: _entries[index].questionImages,
          answerImages: _entries[index].answerImages,
          isExpanded: _expandedIndex == index,
          onToggle: () => setState(() => _expandedIndex = _expandedIndex == index ? null : index),
          onDelete: () => setState(() => _entries.length > 1 ? _entries.removeAt(index) : null),
          onAddImage: (isQ) => _addImage(index, isQ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () => setState(() {
              _entries.add(CardEntry());
              _expandedIndex = _entries.length - 1;
            }),
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: textColor.withValues(alpha: 0.1)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              foregroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              "ADD ANOTHER CARD",
              style: context.bodyLarge!.copyWith(color: context.isDarkMode ? Colors.black : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class CardEntry {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final List<File> questionImages = [];
  final List<File> answerImages = [];

  bool get isValid => questionController.text.isNotEmpty && answerController.text.isNotEmpty;
}
