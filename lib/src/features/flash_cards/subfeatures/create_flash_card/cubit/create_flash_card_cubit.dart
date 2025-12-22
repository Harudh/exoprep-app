import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_flash_card_state.dart';

class CreateFlashCardCubit extends Cubit<CreateFlashCardState> {
  CreateFlashCardCubit({required this.deckId}) : super(CreateFlashCardInitial());

  final String deckId;
}
