import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:root/src/features/flash_cards/models/data_model/decks_data_model.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';
import 'package:root/src/features/flash_cards/repository/flash_cards_repository.dart';

part 'decks_view_state.dart';

class DecksViewCubit extends Cubit<DecksViewState> {
  DecksViewCubit({required this.collectionId}) : super(DecksViewInitial()) {
    _initializeDecksList(collectionId);
  }

  final String collectionId;
  StreamSubscription<List<DeckDataModel>>? _decksListSubscription;

  final FlashCardsRepository _repository = FlashCardsRepository();
  List<DeckDataModel> decks = [];

  Future<void> saveDeck({required String name, required String collectionId}) async {
    try {
      await _repository.saveDecks(name: name, collectionId: collectionId);
      emit(CreateDecksSuccessState());
    } catch (e) {
      emit(CreateDecksErrorState(e.toString()));
    }
  }

  void _initializeDecksList(String id) {
    emit(LoadingState());

    _decksListSubscription = _repository
        .watchDecksList(id)
        .listen(
          (updatedCollections) {
            decks = updatedCollections;
            emit(DecksLoadedState(decks));
            log('Collections length: ${decks.length}');
          },

          onError: (error) {
            emit(LoadDecksErrorState(error.toString()));
          },
        );
  }

  List<FlashCardDataModel> getFlashCards(String deckId) {
    try {
      final list = _repository.getFlashCardsList(deckId);
      return list;
    } catch (e) {
      log('Error in getting the FlashCardslist');
      return [];
    }
  }

  @override
  Future<void> close() {
    _decksListSubscription?.cancel();
    return super.close();
  }
}
