import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/cubit/decks_view_cubit.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/widgets/decks_list_tile.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/widgets/create_decks_widget.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/widgets/flash_cards_study_view.dart';

class DecksListView extends StatefulWidget {
  const DecksListView({super.key, required this.collectionId, required this.collectionName});

  final String collectionId;
  final String collectionName;

  @override
  State<DecksListView> createState() => _DecksListViewState();
}

class _DecksListViewState extends State<DecksListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DecksViewCubit, DecksViewState>(
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
                leading: Center(
                  child: GestureDetector(
                    onTap: () {
                      router.pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: const Icon(Icons.arrow_back, size: 18)),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    widget.collectionName,
                    style: TextStyle(color: context.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.more_vert, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              if (state is LoadingState && context.read<DecksViewCubit>().decks.isEmpty) ...[
                const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              ] else if (state is DecksLoadedState || context.read<DecksViewCubit>().decks.isNotEmpty) ...[
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
                      final deck = context.read<DecksViewCubit>().decks[index];
                      return DeckTileWidget(
                        deck: deck,
                        onTap: () {
                          final cubit = context.read<DecksViewCubit>();
                          if (deck.cardsCount != null && deck.cardsCount! > 0) {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: Text('Choose Action', style: context.bodyLarge),
                                message: Text('What would you like to do?', style: context.labelSmall),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      final list = cubit.getFlashCards(deck.id!);
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FlashCardsWaveStyle(flashCards: list)),
                                      );
                                    },
                                    child: Text('Study Cards', style: context.bodyLarge),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.pushNamed(AppRoute.cardsListView.name, extra: {'id': deck.id, 'name': deck.name});
                                    },
                                    child: Text('View Cards', style: context.bodyLarge),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  isDefaultAction: true,
                                  isDestructiveAction: true,
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel', style: context.bodyLarge!.copyWith(color: Colors.red)),
                                ),
                              ),
                            );
                          } else {
                            context.pushNamed(AppRoute.cardsListView.name, extra: {'id': deck.id, 'name': deck.name});
                          }
                        },
                      );
                    }, childCount: context.read<DecksViewCubit>().decks.length),
                  ),
                ),
              ] else if (context.read<DecksViewCubit>().decks.isEmpty) ...[
                const SliverFillRemaining(child: Center(child: Text('No collections yet'))),
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: showDecksDialog,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void showDecksDialog() {
    final cubit = context.read<DecksViewCubit>();
    showDialog(
      context: context,
      builder: (context) => CreateDeckWidget(
        onCreate: (name) {
          log("Decks name is : $name,");

          cubit.saveDeck(name: name, collectionId: widget.collectionId);
        },
      ),
    );
  }
}
