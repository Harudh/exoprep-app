import 'package:isar_community/isar.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';

part 'flash_cards_isar_model.g.dart';

@collection
class FlashCardsIsarModel {
  /// Isar Auto-Increment ID
  Id id = Isar.autoIncrement;

  @Index()
  String? deckId;

  String? questionText;
  String? answerText;

  List<String>? questionImages;
  List<String>? answerImages;

  int? orderIndex;

  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  /// 1. Default empty constructor (Required by Isar)
  FlashCardsIsarModel();

  /// 2. Factory Constructor: Converts DataModel -> Isar Model
  factory FlashCardsIsarModel.fromDataModel(FlashCardDataModel data) {
    final model = FlashCardsIsarModel()
      ..deckId = data.deckId
      ..questionText = data.questionText
      ..answerText = data.answerText
      ..questionImages = data.questionImages
      ..answerImages = data.answerImages
      ..orderIndex = data.orderIndex
      ..createdAt = data.createdAt != null ? DateTime.tryParse(data.createdAt!) : null
      ..updatedAt = data.updatedAt != null ? DateTime.tryParse(data.updatedAt!) : null
      ..deletedAt = data.deletedAt != null ? DateTime.tryParse(data.deletedAt!) : null;

    // If the remote/DataModel ID is a numeric string, we map it to Isar's Id.
    // Otherwise, Isar will auto-increment.
    if (data.id != null) {
      final parsedId = int.tryParse(data.id!);
      if (parsedId != null) {
        model.id = parsedId;
      }
    }

    return model;
  }

  /// 3. Helper Method: Converts Isar Model -> Data Model
  /// Useful when sending local data back to a service or API layer.
  FlashCardDataModel toDataModel() {
    return FlashCardDataModel(
      id: id.toString(),
      deckId: deckId,
      questionText: questionText,
      answerText: answerText,
      questionImages: questionImages,
      answerImages: answerImages,
      orderIndex: orderIndex,
      createdAt: createdAt?.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
      deletedAt: deletedAt?.toIso8601String(),
    );
  }
}
