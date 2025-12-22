import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/cubit/decks_view_cubit.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/widgets/create_decks_widget.dart';
import 'package:root/src/features/flash_cards/subfeatures/decks_view/widgets/decks_list_tile.dart';

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
                snap: true,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                surfaceTintColor: context.theme.colorScheme.surface,
                elevation: 0,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(widget.collectionName, style: context.headlineMedium),
                ),
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
                          context.pushNamed(AppRoute.cardsListView.name, extra: {'id': deck.id, 'name': deck.name});
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
