import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';

class CreateFlashCardView extends StatefulWidget {
  final String deckId;
  final String deckName;
  final void Function(List<FlashCardDataModel> cards) onSave;

  const CreateFlashCardView({required this.deckId, required this.deckName, required this.onSave, super.key});

  @override
  State<CreateFlashCardView> createState() => _CreateFlashCardViewState();
}

class _CreateFlashCardViewState extends State<CreateFlashCardView> with TickerProviderStateMixin {
  final List<CardEntry> _cards = [CardEntry()];
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  int? _expandedIndex = 0;
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabController.dispose();
    for (var card in _cards) {
      card.dispose();
    }
    super.dispose();
  }

  // --- Logic & Validation ---

  void _validateAndSubmit() {
    int firstIncompleteIndex = _cards.indexWhere((card) => !card.isComplete);

    if (firstIncompleteIndex != -1) {
      setState(() => _expandedIndex = firstIncompleteIndex);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text('Please complete Card ${firstIncompleteIndex + 1} before saving.')),
            ],
          ),
          backgroundColor: const Color(0xFFF59E0B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final List<FlashCardDataModel> models = _cards.asMap().entries.map((entry) {
      final index = entry.key;
      final card = entry.value;
      return FlashCardDataModel(
        deckId: widget.deckId,
        questionText: card.questionController.text.trim(),
        answerText: card.answerController.text.trim(),
        questionImages: card.questionImages.map((f) => f.path).toList(),
        answerImages: card.answerImages.map((f) => f.path).toList(),
        orderIndex: index,
        createdAt: DateTime.now().toIso8601String(),
      );
    }).toList();

    widget.onSave(models);
  }

  Future<void> _pickImages(int cardIndex, bool isQuestion) async {
    final List<XFile> images = await _picker.pickMultiImage(maxWidth: 1920, maxHeight: 1080, imageQuality: 85);

    if (images.isNotEmpty) {
      setState(() {
        final card = _cards[cardIndex];
        final files = images.map((e) => File(e.path));
        isQuestion ? card.questionImages.addAll(files) : card.answerImages.addAll(files);
      });
    }
  }

  void _addCard() {
    setState(() {
      _cards.add(CardEntry());
      _expandedIndex = _cards.length - 1;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // --- UI Components ---

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final completedCount = _cards.where((c) => c.isComplete).length;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF8FAFC),
      appBar: _buildAppBar(completedCount, isDark),
      body: Column(
        children: [
          _ProgressBar(completedCount: completedCount, total: _cards.length, isDark: isDark),
          Expanded(
            child: ReorderableListView.builder(
              scrollController: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _cards.length,
              buildDefaultDragHandles: false,
              proxyDecorator: (child, index, animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.05,
                      child: Transform.rotate(
                        angle: 0.02,
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(16),
                          shadowColor: const Color(0x406366F1),
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: child,
                );
              },
              onReorder: (oldIdx, newIdx) {
                setState(() {
                  if (newIdx > oldIdx) newIdx--;
                  final item = _cards.removeAt(oldIdx);
                  _cards.insert(newIdx, item);
                  _expandedIndex = (_expandedIndex == oldIdx) ? newIdx : null;
                });
              },
              itemBuilder: (context, index) => _FlashCardTile(
                key: ValueKey(_cards[index]),
                index: index,
                card: _cards[index],
                isExpanded: _expandedIndex == index,
                onToggle: () => setState(() => _expandedIndex = _expandedIndex == index ? null : index),
                onDelete: () => setState(() {
                  if (_cards.length > 1) _cards.removeAt(index);
                }),
                onDuplicate: () => setState(() {
                  _cards.insert(index + 1, _cards[index].clone());
                  _expandedIndex = index + 1;
                }),
                onAddImage: (isQ) => _pickImages(index, isQ),
                onUpdate: () => setState(() {}),
                isDark: isDark,
              ),
            ),
          ),
          _BottomActionArea(onAdd: _addCard, fabController: _fabController, isDark: isDark),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(int completedCount, bool isDark) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isDark ? Colors.black : const Color(0xFFF8FAFC),
      surfaceTintColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.deckName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.grey.shade900),
          ),
          Text(
            '$completedCount/${_cards.length} complete',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF06B6D4)]),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: const Color(0xFF10B981).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _validateAndSubmit,
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// --- Helper Widgets with Smooth Animations ---

class _FlashCardTile extends StatelessWidget {
  final int index;
  final CardEntry card;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final Function(bool) onAddImage;
  final VoidCallback onUpdate;
  final bool isDark;

  const _FlashCardTile({
    super.key,
    required this.index,
    required this.card,
    required this.isExpanded,
    required this.onToggle,
    required this.onDelete,
    required this.onDuplicate,
    required this.onAddImage,
    required this.onUpdate,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6366F1);
    const successColor = Color(0xFF10B981);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isExpanded
              ? primaryColor
              : (card.isComplete
                    ? successColor.withValues(alpha: isDark ? 0.5 : 0.4)
                    : (isDark ? Colors.grey.shade800 : const Color(0xFFE2E8F0))),
          width: isExpanded ? 2.5 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isExpanded
                ? primaryColor.withValues(alpha: 0.15)
                : (card.isComplete ? successColor.withValues(alpha: 0.1) : Colors.black.withValues(alpha: isDark ? 0.3 : 0.06)),
            blurRadius: isExpanded ? 16 : 8,
            offset: Offset(0, isExpanded ? 8 : 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            Material(
              color: isExpanded ? (isDark ? primaryColor.withValues(alpha: 0.1) : const Color(0xFFF0F4FF)) : Colors.transparent,
              child: InkWell(
                onTap: onToggle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      // Drag Handle
                      ReorderableDragStartListener(
                        index: index,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor.withValues(alpha: isDark ? 0.2 : 0.15),
                                primaryColor.withValues(alpha: isDark ? 0.1 : 0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor.withValues(alpha: isDark ? 0.3 : 0.25)),
                          ),
                          child: const Icon(Icons.drag_handle_rounded, color: primaryColor, size: 20),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Status Badge
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: card.isComplete
                                ? [successColor, successColor.withValues(alpha: 0.8)]
                                : [primaryColor, const Color(0xFF8B5CF6)],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: (card.isComplete ? successColor : primaryColor).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: card.isComplete
                              ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                              : Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.questionController.text.isEmpty ? 'New Card ${index + 1}' : card.questionController.text,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: isDark
                                    ? (card.isComplete ? Colors.white : Colors.grey.shade400)
                                    : (card.isComplete ? Colors.grey.shade900 : Colors.grey.shade500),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (card.answerController.text.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                card.answerController.text,
                                style: TextStyle(fontSize: 12, color: isDark ? Colors.grey.shade600 : Colors.grey.shade500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Image Count Badge
                      if ((card.questionImages.length + card.answerImages.length) > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? primaryColor.withValues(alpha: 0.2) : primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor.withValues(alpha: isDark ? 0.3 : 0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.image_rounded, size: 12, color: primaryColor),
                              const SizedBox(width: 4),
                              Text(
                                '${card.questionImages.length + card.answerImages.length}',
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(width: 8),

                      // Expand Icon
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 250),
                        turns: isExpanded ? 0.5 : 0,
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Expanded Content
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: isDark ? Colors.grey.shade800 : const Color(0xFFE2E8F0))),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _InputBlock(
                            label: 'Question',
                            controller: card.questionController,
                            images: card.questionImages,
                            onAdd: () => onAddImage(true),
                            onChanged: onUpdate,
                            isDark: isDark,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 20),
                          _InputBlock(
                            label: 'Answer',
                            controller: card.answerController,
                            images: card.answerImages,
                            onAdd: () => onAddImage(false),
                            onChanged: onUpdate,
                            isDark: isDark,
                            color: successColor,
                          ),
                          const SizedBox(height: 16),
                          _ActionButtons(onDelete: onDelete, onDuplicate: onDuplicate, isDark: isDark),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputBlock extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<File> images;
  final VoidCallback onAdd;
  final VoidCallback onChanged;
  final bool isDark;
  final Color color;

  const _InputBlock({
    required this.label,
    required this.controller,
    required this.images,
    required this.onAdd,
    required this.onChanged,
    required this.isDark,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: isDark ? 0.15 : 0.1),
                color.withValues(alpha: isDark ? 0.08 : 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.8)]),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 6, offset: const Offset(0, 2))],
                ),
                child: Icon(
                  label == 'Question' ? Icons.help_outline_rounded : Icons.lightbulb_outline_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.grey.shade900),
              ),
              const Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_photo_alternate_rounded, size: 16, color: color),
                        const SizedBox(width: 4),
                        Text(
                          'Add',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Image Preview
        if (images.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.only(right: 8),
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isDark ? Colors.grey.shade800 : const Color(0xFFE2E8F0), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  image: DecorationImage(image: FileImage(images[i]), fit: BoxFit.cover),
                ),
              ),
            ),
          ),

        // Text Field
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.grey.shade800 : const Color(0xFFCBD5E1), width: 1.5),
          ),
          child: TextField(
            controller: controller,
            maxLines: 3,
            onChanged: (_) => onChanged(),
            style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.grey.shade900, height: 1.5),
            decoration: InputDecoration(
              hintText: 'Type $label here...',
              hintStyle: TextStyle(color: isDark ? Colors.grey.shade600 : Colors.grey.shade400, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final bool isDark;

  const _ActionButtons({required this.onDelete, required this.onDuplicate, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onDuplicate,
            icon: const Icon(Icons.content_copy_rounded, size: 16),
            label: const Text('Duplicate', style: TextStyle(fontSize: 13)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: isDark ? Colors.grey.shade700 : const Color(0xFFCBD5E1), width: 1.5),
              foregroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded, size: 16),
            label: const Text('Delete', style: TextStyle(fontSize: 13)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colors.red.withValues(alpha: 0.5), width: 1.5),
              foregroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int completedCount;
  final int total;
  final bool isDark;

  const _ProgressBar({required this.completedCount, required this.total, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: completedCount > 0 ? 4 : 0,
      child: LinearProgressIndicator(
        value: total == 0 ? 0 : completedCount / total,
        backgroundColor: isDark ? Colors.grey.shade900 : const Color(0xFFE2E8F0),
        valueColor: const AlwaysStoppedAnimation(Color(0xFF10B981)),
        minHeight: 4,
      ),
    );
  }
}

class _BottomActionArea extends StatelessWidget {
  final VoidCallback onAdd;
  final AnimationController fabController;
  final bool isDark;

  const _BottomActionArea({required this.onAdd, required this.fabController, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : const Color(0xFFF8FAFC),
        // border: Border(top: BorderSide(color: isDark ? Colors.grey.shade800 : const Color(0xFFE2E8F0))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ScaleTransition(
        scale: fabController,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
            borderRadius: BorderRadius.all(Radius.circular(14)),
            boxShadow: [BoxShadow(color: Color(0x406366F1), blurRadius: 16, offset: Offset(0, 6))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_rounded, color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'Add Another Card',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white, letterSpacing: 0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardEntry {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final List<File> questionImages = [];
  final List<File> answerImages = [];

  bool get isComplete => questionController.text.trim().isNotEmpty && answerController.text.trim().isNotEmpty;

  void dispose() {
    questionController.dispose();
    answerController.dispose();
  }

  CardEntry clone() {
    final entry = CardEntry();
    entry.questionController.text = questionController.text;
    entry.answerController.text = answerController.text;
    entry.questionImages.addAll(questionImages);
    entry.answerImages.addAll(answerImages);
    return entry;
  }
}
