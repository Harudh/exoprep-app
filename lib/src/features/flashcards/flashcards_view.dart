// lib/presentation/views/flashcards/flashcards_view.dart

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:root/data/local/services/flashcard_local_service.dart';
import 'package:root/data/models/flashcard_model/flashcard_schema_model.dart';
import 'package:root/src/features/flashcards/flashcards_viewmodel.dart';
import 'package:root/src/features/flashcards/widgets/flashcard.dart';
import 'package:root/src/features/flashcards/widgets/flashcard_type_chip.dart';
import 'package:root/src/repositories/flashcards_repository.dart';

part 'flashcards_mixin.dart';

class FlashcardsView extends StatefulWidget {
  const FlashcardsView({super.key});

  @override
  State<FlashcardsView> createState() => _FlashcardsViewState();
}

class _FlashcardsViewState extends State<FlashcardsView> with FlashcardsMixin {
  late final FlashcardViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Initialize ViewModel
    final repository = FlashcardRepository(FlashcardLocalService());
    _viewModel = FlashcardViewModel(repository);
    _viewModel.initialize();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildTypeSelector(context),
          _buildCreateOptions(context),
          _buildFlashcardsList(context),
        ],
      ),
    );
  }

  // App Bar
  Widget _buildAppBar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text(
          'Flashcards',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        titlePadding: EdgeInsets.only(left: 20, bottom: 16),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _showSearchDialog(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        ),
      ],
    );
  }

  // Type Selector
  Widget _buildTypeSelector(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ValueListenableBuilder<FlashcardType>(
          valueListenable: _viewModel.selectedTypeNotifier,
          builder: (context, selectedType, child) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: [
                FlashcardTypeChip(
                  label: 'Short Notes',
                  icon: Icons.note,
                  isSelected: selectedType == FlashcardType.shortNotes,
                  onTap: () => _viewModel.setSelectedType(FlashcardType.shortNotes),
                ),
                const SizedBox(width: 8),
                FlashcardTypeChip(
                  label: 'Quiz',
                  icon: Icons.quiz,
                  isSelected: selectedType == FlashcardType.quiz,
                  onTap: () => _viewModel.setSelectedType(FlashcardType.quiz),
                ),
                const SizedBox(width: 8),
                FlashcardTypeChip(
                  label: 'Summary',
                  icon: Icons.summarize,
                  isSelected: selectedType == FlashcardType.summary,
                  onTap: () => _viewModel.setSelectedType(FlashcardType.summary),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Create Options (Horizontal Scroll)
  Widget _buildCreateOptions(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.85;

    final createOptions = [
      {
        'icon': Icons.picture_as_pdf,
        'title': 'From PDF',
        'subtitle': 'Extract content from PDF',
        'color': Colors.red,
        'onTap': () async {
          final file = await pickPDFFile();
          if (file != null && mounted) {
            showInfo('PDF processing with Gemini AI coming soon!');
          }
        },
      },
      {
        'icon': Icons.image,
        'title': 'From Image',
        'subtitle': 'Extract text from image',
        'color': Colors.blue,
        'onTap': () async {
          final file = await pickImageFile();
          if (file != null && mounted) {
            showInfo('Image OCR processing coming soon!');
          }
        },
      },
      {
        'icon': Icons.camera_alt,
        'title': 'Take Photo',
        'subtitle': 'Capture and extract text',
        'color': Colors.purple,
        'onTap': () async {
          final file = await takePhoto();
          if (file != null && mounted) {
            showInfo('Photo OCR processing coming soon!');
          }
        },
      },
      {
        'icon': Icons.text_fields,
        'title': 'From Text',
        'subtitle': 'Type or paste content',
        'color': Colors.green,
        'onTap': () => showTextInputDialog(context, _viewModel),
      },
    ];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Create New Flashcard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: createOptions.length,
              itemBuilder: (context, index) {
                final option = createOptions[index];
                return GestureDetector(
                  onTap: option['onTap']! as VoidCallback,
                  child: Container(
                    width: cardWidth,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (option['color']! as Color).withValues(alpha: 0.8),
                          (option['color']! as Color),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (option['color']! as Color).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            option['icon']! as IconData,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                option['title'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                option['subtitle']! as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Flashcards List
  Widget _buildFlashcardsList(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _viewModel.isLoadingNotifier,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return ValueListenableBuilder<List<FlashcardSchemaModel>>(
          valueListenable: _viewModel.flashcardsNotifier,
          builder: (context, flashcards, child) {
            if (flashcards.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.style_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No flashcards yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your first flashcard above',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final flashcard = flashcards[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FlashcardCard(
                        flashcard: flashcard,
                        onTap: () {},
                        onBookmark: () => _viewModel.toggleBookmark(flashcard.id),
                        onDelete: () => _confirmDelete(context, flashcard.id),
                      ),
                    );
                  },
                  childCount: flashcards.length,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Show search dialog
  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Flashcards'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Enter search query',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (query) {
            _viewModel.searchFlashcards(query);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _viewModel.loadFlashcards();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          ElevatedButton(
            onPressed: () {
              _viewModel.searchFlashcards(searchController.text);
              Navigator.pop(context);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  // Confirm delete dialog
  Future<void> _confirmDelete(BuildContext context, int id) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _viewModel.deleteFlashcard(id);
      if (mounted) {
        showSuccess('Flashcard deleted');
      }
    }
  }

  void showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.blue),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}
