import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/common/ui/widgets/circle_button.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/cubit/flash_cards_cubit.dart';
import 'package:root/src/features/flash_cards/widgets/collection_card_tile.dart';
import 'package:toastification/toastification.dart';

import 'create_flashcard_collection_widget.dart';

class FlashCardsCollectionView extends StatefulWidget {
  const FlashCardsCollectionView({super.key});

  @override
  State<FlashCardsCollectionView> createState() => _FlashCardsCollectionViewState();
}

class _FlashCardsCollectionViewState extends State<FlashCardsCollectionView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlashCardsCubit, FlashCardsState>(
      listener: (prev, curr) => {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                surfaceTintColor: context.theme.colorScheme.surface,
                elevation: 0,
                actions: [
                  CircleButton(icon: Icons.more_vert),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  centerTitle: false,
                  title: Text(
                    'Flashcards',
                    style: TextStyle(color: context.bodyLarge?.color, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (state is LoadingState && context.read<FlashCardsCubit>().collections.isEmpty) ...[
                const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              ] else if (state is CollectionsLoadedState || context.read<FlashCardsCubit>().collections.isNotEmpty) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.88,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final collection = context.read<FlashCardsCubit>().collections[index];
                      return CollectionCardTile(
                        title: collection.title ?? '',
                        tag: collection.tag ?? '',
                        accentColor: Color(collection.color!),
                        cardCount: collection.cardCount ?? 0,
                        onTap: () {
                          context.pushNamed(AppRoute.decksListView.name, extra: {'id': collection.id, 'name': collection.title});
                        },
                      );
                    }, childCount: context.read<FlashCardsCubit>().collections.length),
                  ),
                ),
              ] else if (context.read<FlashCardsCubit>().collections.isEmpty) ...[
                const SliverFillRemaining(child: Center(child: Text('No collections yet'))),
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: showCollectionCreationDialog,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void showCollectionCreationDialog() {
    final cubit = context.read<FlashCardsCubit>();
    showDialog(
      context: context,
      builder: (context) => CreateFlashCardsCollectionWidget(
        onCreate: (title, tag, color) {
          log("Creating set: $title, $tag, $color");

          // !TODO:check color type
          cubit.saveCollection(title: title, tag: tag, color: color.intValue);
        },
      ),
    );
  }
}
