import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/features/flash_cards/cubit/flash_cards_cubit.dart';

import 'flash_cards_collection_view.dart';

class FlashCardsCollectionScreen extends StatefulWidget {
  const FlashCardsCollectionScreen({super.key});

  @override
  State<FlashCardsCollectionScreen> createState() => _FlashCardsCollectionScreenState();
}

class _FlashCardsCollectionScreenState extends State<FlashCardsCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => FlashCardsCubit(), child: const FlashCardsCollectionView());
  }
}
