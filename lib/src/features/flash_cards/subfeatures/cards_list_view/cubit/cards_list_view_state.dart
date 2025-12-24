part of 'cards_list_view_cubit.dart';

sealed class CardsListViewState {}

final class CardsListViewInitial extends CardsListViewState {}

final class LoadingState extends CardsListViewState {}

final class CardsLoadedState extends CardsListViewState {
  final List<FlashCardDataModel> cards;
  CardsLoadedState(this.cards);
}

final class LoadCardsErrorState extends CardsListViewState {
  final String error;
  LoadCardsErrorState(this.error);
}

final class DeleteCardSuccessState extends CardsListViewState {}

final class DeleteCardErrorState extends CardsListViewState {
  final String error;
  DeleteCardErrorState(this.error);
}
