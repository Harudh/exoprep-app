// lib/presentation/views/flashcards/flashcards_mixin.dart

part of 'flashcards_view.dart';


mixin FlashcardsMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    textController.dispose();
    titleController.dispose();
    super.dispose();
  }

  // Pick PDF file
  Future<File?> pickPDFFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      _showError('Failed to pick PDF: $e');
      return null;
    }
  }

  // Pick image file
  Future<File?> pickImageFile() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      _showError('Failed to pick image: $e');
      return null;
    }
  }

  // Take photo
  Future<File?> takePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      _showError('Failed to take photo: $e');
      return null;
    }
  }

  // Show text input dialog
  Future<void> showTextInputDialog(
      BuildContext context,
      FlashcardViewModel viewModel,
      ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Flashcard from Text'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: viewModel.isGeneratingNotifier,
            builder: (context, isGenerating, child) {
              return ElevatedButton(
                onPressed: isGenerating
                    ? null
                    : () async {
                  if (textController.text.isNotEmpty &&
                      titleController.text.isNotEmpty) {
                    final success = await viewModel.createFlashcardFromText(
                      content: textController.text,
                      title: titleController.text,
                    );

                    if (success && context.mounted) {
                      textController.clear();
                      titleController.clear();
                      Navigator.pop(context);
                      _showSuccess('Flashcard created successfully!');
                    }
                  }
                },
                child: isGenerating
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Create'),
              );
            },
          ),
        ],
      ),
    );
  }

  // Show type selection dialog
  Future<void> showTypeSelectionDialog(
      BuildContext context,
      FlashcardViewModel viewModel,
      ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Flashcard Type'),
        content: ValueListenableBuilder<FlashcardType>(
          valueListenable: viewModel.selectedTypeNotifier,
          builder: (context, selectedType, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: FlashcardType.values.map((type) {
                return RadioListTile<FlashcardType>(
                  title: Text(_getTypeLabel(type)),
                  subtitle: Text(_getTypeDescription(type)),
                  value: type,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  // Get flashcard type label
  String _getTypeLabel(FlashcardType type) {
    switch (type) {
      case FlashcardType.shortNotes:
        return 'Short Notes';
      case FlashcardType.quiz:
        return 'Quiz';
      case FlashcardType.summary:
        return 'Summary';
    }
  }

  // Get flashcard type description
  String _getTypeDescription(FlashcardType type) {
    switch (type) {
      case FlashcardType.shortNotes:
        return 'Quick reference notes';
      case FlashcardType.quiz:
        return 'Question and answer format';
      case FlashcardType.summary:
        return 'Condensed overview';
    }
  }

  // Show error snackbar
  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Show success snackbar
  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Show info snackbar
  void _showInfo(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
