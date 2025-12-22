part of 'create_flash_card_cubit.dart';

sealed class CreateFlashCardState extends Equatable {
  const CreateFlashCardState();

  @override
  List<Object> get props => [];
}

final class CreateFlashCardInitial extends CreateFlashCardState {}
