import 'dart:developer';
import 'package:isar_community/isar.dart';
import 'package:root/data/local/database/isar_database.dart';
import 'package:root/src/features/flash_cards/models/data_model/decks_data_model.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';
import 'package:root/src/features/flash_cards/models/isar_model.dart/decks_isar_model.dart';
import 'package:root/src/features/flash_cards/models/isar_model.dart/flash_cards_isar_model.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_collection_data_model.dart';
import 'package:root/src/features/flash_cards/models/isar_model.dart/flash_cards_collection_isar_model.dart';

class FlashCardsRepository {
  Isar get _isar => IsarService.instance.isar;

  Future<void> saveCollection({required String title, required String tag, required int color}) async {
    final isarModel = FlashCardsCollectionIsarModel()
      ..title = title
      ..tag = tag.toLowerCase().trim()
      ..colorHex = color
      ..cardCount = 0
      ..deckIds = []
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.flashCardsCollectionIsarModels.put(isarModel);
    });
  }

  Stream<List<FlashCardsCollectionDataModel>> watchCollection() {
    return _isar.flashCardsCollectionIsarModels
        .where()
        .filter()
        .deletedAtIsNull()
        .watch(fireImmediately: true)
        .map((isarModels) => isarModels.map((isarModel) => _toDataModel(isarModel)).toList());
  }

  Stream<List<DeckDataModel>> watchDecksList(String collectionId) {
    return _isar.decksIsarModels
        .filter()
        .collectionIdEqualTo(collectionId)
        .and()
        .deletedAtIsNull()
        .watch(fireImmediately: true)
        .map((isarModels) => isarModels.map((isarModel) => _toDecksDataModel(isarModel)).toList());
  }

  Future<void> saveDecks({required String name, required String collectionId}) async {
    final isarModel = DecksIsarModel()
      ..name = name
      ..collectionId = collectionId
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.decksIsarModels.put(isarModel);
    });
  }

  Future<void> saveFlashCards({required String deckId, required List<FlashCardDataModel> cards}) async {
    final isarModels = cards.map((card) {
      final data = FlashCardDataModel(
        id: card.id,
        deckId: card.deckId ?? deckId,
        questionText: card.questionText,
        answerText: card.answerText,
        questionImages: card.questionImages,
        answerImages: card.answerImages,
        orderIndex: card.orderIndex,
        createdAt: card.createdAt ?? DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        deletedAt: card.deletedAt,
      );
      return FlashCardsIsarModel.fromDataModel(data);
    }).toList();

    await _isar.writeTxn(() async {
      await _isar.flashCardsIsarModels.putAll(isarModels);
    });
  }

  Future<void> updateDeckAndCollectionCounts(String deckId, int cardsCount) async {
    try {
      final parsedDeckId = int.tryParse(deckId);
      if (parsedDeckId == null) {
        log('updateDeckAndCollectionCounts: Invalid deckId: $deckId');
        return;
      }

      final deck = await _isar.decksIsarModels.where().idEqualTo(parsedDeckId).findFirst();

      if (deck == null) {
        log('updateDeckAndCollectionCounts: Deck not found for id: $deckId');
        return;
      }

      deck
        ..cardsCount = (deck.cardsCount ?? 0) + cardsCount
        ..updatedAt = DateTime.now();

      final collectionId = deck.collectionId;
      if (collectionId == null) {
        log('updateDeckAndCollectionCounts: Deck has no collectionId');
        await _isar.writeTxn(() async {
          await _isar.decksIsarModels.put(deck);
        });
        return;
      }

      final parsedCollectionId = int.tryParse(collectionId);
      if (parsedCollectionId == null) {
        log('updateDeckAndCollectionCounts: Invalid collectionId: $collectionId');
        await _isar.writeTxn(() async {
          await _isar.decksIsarModels.put(deck);
        });
        return;
      }

      final collection = await _isar.flashCardsCollectionIsarModels.where().idEqualTo(parsedCollectionId).findFirst();

      if (collection == null) {
        log('updateDeckAndCollectionCounts: Collection not found for id: $collectionId');
        await _isar.writeTxn(() async {
          await _isar.decksIsarModels.put(deck);
        });
        return;
      }

      collection
        ..cardCount = (collection.cardCount ?? 0) + cardsCount
        ..updatedAt = DateTime.now();

      await _isar.writeTxn(() async {
        await _isar.decksIsarModels.put(deck);
        await _isar.flashCardsCollectionIsarModels.put(collection);
      });
    } catch (e, st) {
      log('updateDeckAndCollectionCounts error: $e');
      log('Stacktrace: $st');
    }
  }

  List<FlashCardDataModel> getFlashCardsList(String deckId) {
    final isarModels = _isar.flashCardsIsarModels
        .filter()
        .deckIdEqualTo(deckId)
        .deletedAtIsNull()
        .sortByOrderIndex()
        .findAllSync();

    return isarModels.map((isarModel) => _toFlashCardDataModel(isarModel)).toList();
  }

  Stream<List<FlashCardDataModel>> watchFlashCardsList(String deckId) {
    return _isar.flashCardsIsarModels
        .filter()
        .deckIdEqualTo(deckId)
        .and()
        .deletedAtIsNull()
        .sortByOrderIndex()
        .watch(fireImmediately: true)
        .map((isarModels) => isarModels.map((isarModel) => _toFlashCardDataModel(isarModel)).toList());
  }

  Future<void> deleteFlashCard(String cardId) async {
    try {
      final parsedId = int.tryParse(cardId);
      if (parsedId == null) {
        log('deleteFlashCard: Invalid cardId: $cardId');
        return;
      }

      final card = await _isar.flashCardsIsarModels.where().idEqualTo(parsedId).findFirst();

      if (card == null) {
        log('deleteFlashCard: Card not found for id: $cardId');
        return;
      }

      card.deletedAt = DateTime.now();

      await _isar.writeTxn(() async {
        await _isar.flashCardsIsarModels.put(card);
      });
    } catch (e, st) {
      log('deleteFlashCard error: $e');
      log('Stacktrace: $st');
    }
  }
}

DeckDataModel _toDecksDataModel(DecksIsarModel isarModel) {
  return DeckDataModel(
    id: isarModel.id.toString(),
    name: isarModel.name,
    cardsCount: isarModel.cardsCount,
    collectionId: isarModel.collectionId,
    createdAt: isarModel.createdAt?.toIso8601String(),
    updatedAt: isarModel.updatedAt?.toIso8601String(),
    deletedAt: isarModel.deletedAt?.toIso8601String(),
  );
}

FlashCardsCollectionDataModel _toDataModel(FlashCardsCollectionIsarModel isarModel) {
  return FlashCardsCollectionDataModel(
    id: isarModel.id.toString(),
    title: isarModel.title,
    tag: isarModel.tag,
    color: isarModel.colorHex,
    cardCount: isarModel.cardCount,
    deckIds: isarModel.deckIds,
    createdAt: isarModel.createdAt?.toIso8601String(),
    updatedAt: isarModel.updatedAt?.toIso8601String(),
    deletedAt: isarModel.deletedAt?.toIso8601String(),
  );
}

FlashCardDataModel _toFlashCardDataModel(FlashCardsIsarModel isarModel) {
  return FlashCardDataModel(
    id: isarModel.id.toString(),
    deckId: isarModel.deckId,
    questionText: isarModel.questionText,
    answerText: isarModel.answerText,
    questionImages: isarModel.questionImages,
    answerImages: isarModel.answerImages,
    orderIndex: isarModel.orderIndex,
    createdAt: isarModel.createdAt?.toIso8601String(),
    updatedAt: isarModel.updatedAt?.toIso8601String(),
    deletedAt: isarModel.deletedAt?.toIso8601String(),
  );
}
