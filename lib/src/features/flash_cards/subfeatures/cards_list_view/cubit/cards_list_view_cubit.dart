import 'package:bloc/bloc.dart';

part 'cards_list_view_state.dart';

class CardsListViewCubit extends Cubit<CardsListViewState> {
  CardsListViewCubit({required this.decksId}) : super(CardsListViewInitial());

  final String decksId;
}
