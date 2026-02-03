import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/features/flash_cards/cubit/flash_cards_cubit.dart';
import 'package:root/src/features/flash_cards/widgets/collection_card_tile.dart';

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
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: BackgroundGradient(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  elevation: 0,
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                          border: Border.all(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                        ),
                        child: const Icon(IonIcons.notifications, size: 22),
                      ),
                    ),
                    const SizedBox(width: 12),
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
                ] else if (context.read<FlashCardsCubit>().collections.isEmpty) ...[
                  SliverFillRemaining(
                    child: GestureDetector(
                      onTap: showCollectionCreationDialog,
                      child: Center(child: Text('Please add a collection')),
                    ),
                  ),
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
                            context.pushNamed(
                              AppRoute.decksListView.name,
                              extra: {'id': collection.id, 'name': collection.title},
                            );
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
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: FloatingActionButton(
              onPressed: showCollectionCreationDialog,
              isExtended: true,
              shape: CircleBorder(),
              tooltip: 'Create',
              backgroundColor: context.isDarkMode ? Colors.white : Colors.black,
              child: Icon(Icons.add, size: 30, color: context.isDarkMode ? Colors.black : Colors.white),
            ),
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
