import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/subfeatures/create_flash_card/cubit/create_flash_card_cubit.dart';
import 'package:root/src/features/flash_cards/subfeatures/create_flash_card/view/create_flash_cards_view.dart';

class CreateFlashCardsScreen extends StatefulWidget {
  const CreateFlashCardsScreen({super.key, required this.deckId, required this.deckName});

  final String deckId;
  final String deckName;

  @override
  State<CreateFlashCardsScreen> createState() => _CreateFlashCardsScreenState();
}

class _CreateFlashCardsScreenState extends State<CreateFlashCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFlashCardCubit(deckId: widget.deckId),
      child: BlocBuilder<CreateFlashCardCubit, CreateFlashCardState>(
        builder: (context, state) {
          final cubit = context.read<CreateFlashCardCubit>();
          return CreateFlashCardView(
            deckId: widget.deckId,
            deckName: widget.deckName,
            onSave: (cardsList) {
              cubit.saveFlashCards(cards: cardsList);
              context.pop();
            },
          );
        },
      ),
    );
  }
}
