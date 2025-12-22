import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/cubit/cards_list_view_cubit.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/view/cards_list_view.dart';

class CardsListScreen extends StatefulWidget {
  const CardsListScreen({super.key, required this.decksId, required this.deckName});
  final String decksId;

  final String deckName;
  @override
  State<CardsListScreen> createState() => _CardsListScreenState();
}

class _CardsListScreenState extends State<CardsListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsListViewCubit(decksId: widget.decksId),
      child: CardsListView(deckName: widget.deckName),
    );
  }
}
