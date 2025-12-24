import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';
import 'package:root/src/features/flash_cards/repository/flash_cards_repository.dart';

part 'create_flash_card_state.dart';

class CreateFlashCardCubit extends Cubit<CreateFlashCardState> {
  CreateFlashCardCubit({required this.deckId}) : super(CreateFlashCardInitial());

  final String deckId;

  final FlashCardsRepository _repository = FlashCardsRepository();

  Future<void> saveFlashCards({required List<FlashCardDataModel> cards}) async {
    try {
      await _repository.saveFlashCards(deckId: deckId, cards: cards);
      await _repository.updateDeckAndCollectionCounts(deckId);
    } catch (e) {
      log(e.toString());
    }
  }
}
