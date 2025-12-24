import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';
import 'package:root/src/features/flash_cards/repository/flash_cards_repository.dart';

part 'cards_list_view_state.dart';

class CardsListViewCubit extends Cubit<CardsListViewState> {
  CardsListViewCubit({required this.decksId}) : super(CardsListViewInitial()) {
    _initializeCardsList(decksId);
  }

  final String decksId;
  StreamSubscription<List<FlashCardDataModel>>? _cardsListSubscription;

  final FlashCardsRepository _repository = FlashCardsRepository();
  List<FlashCardDataModel> cards = [];

  void _initializeCardsList(String deckId) {
    emit(LoadingState());

    _cardsListSubscription = _repository
        .watchFlashCardsList(deckId)
        .listen(
          (updatedCards) {
            cards = updatedCards;
            emit(CardsLoadedState(cards));
            log('Cards length: ${cards.length}');
          },
          onError: (error) {
            emit(LoadCardsErrorState(error.toString()));
          },
        );
  }

  Future<void> deleteCard(String cardId) async {
    try {
      await _repository.deleteFlashCard(cardId);
      await _repository.updateDeckAndCollectionCounts(decksId);
      emit(DeleteCardSuccessState());
    } catch (e) {
      emit(DeleteCardErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _cardsListSubscription?.cancel();
    return super.close();
  }
}
