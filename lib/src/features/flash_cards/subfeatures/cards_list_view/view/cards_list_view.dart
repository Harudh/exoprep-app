import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/core/common/ui/widgets/background_gradient.dart';
import 'package:root/src/core/common/ui/widgets/circle_button.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/cubit/cards_list_view_cubit.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/widgets/flash_cards_list_tile.dart';

class CardsListView extends StatefulWidget {
  const CardsListView({super.key, required this.deckName});
  final String deckName;

  @override
  State<CardsListView> createState() => _CardsListViewState();
}

class _CardsListViewState extends State<CardsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsListViewCubit, CardsListViewState>(
      listener: (context, state) {
        if (state is DeleteCardSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Card deleted successfully')));
        } else if (state is DeleteCardErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: BackgroundGradient(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12.0),

                    child: CircleButton(
                      icon: Icons.arrow_back,
                      ontap: () {
                        router.pop();
                      },
                    ),
                  ),

                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      widget.deckName,
                      style: TextStyle(color: context.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Center(child: CircleButton(icon: Icons.more_vert)),
                    ),
                  ],
                ),

                if (state is LoadingState)
                  const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
                else if (state is LoadCardsErrorState)
                  SliverFillRemaining(child: Center(child: Text('Error: ${state.error}')))
                else if (state is CardsLoadedState && state.cards.isEmpty)
                  const SliverFillRemaining(child: Center(child: Text('No cards yet. Tap + to add your first card!')))
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final cubit = context.read<CardsListViewCubit>();
                        final card = cubit.cards[index];
                        return FlashCardTile(card: card, onDelete: () => cubit.deleteCard(card.id ?? ''));
                      }, childCount: context.read<CardsListViewCubit>().cards.length),
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(
                AppRoute.createFlashCardsView.name,
                extra: {'id': context.read<CardsListViewCubit>().decksId, 'name': widget.deckName},
              );
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
