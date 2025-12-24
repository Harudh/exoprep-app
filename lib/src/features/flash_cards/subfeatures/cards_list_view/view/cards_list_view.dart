import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/cubit/cards_list_view_cubit.dart';
import 'package:root/src/features/flash_cards/models/data_model/flash_cards_data_model.dart';

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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                title: Text(widget.deckName, style: context.titleLarge),
                centerTitle: true,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                surfaceTintColor: context.theme.colorScheme.surface,
                elevation: 0,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                ],
              ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     child: Text(widget.deckName, style: context.headlineMedium),
              //   ),
              // ),
              if (state is LoadingState)
                const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
              else if (state is LoadCardsErrorState)
                SliverFillRemaining(child: Center(child: Text('Error: ${state.error}')))
              else if (state is CardsLoadedState && state.cards.isEmpty)
                const SliverFillRemaining(child: Center(child: Text('No cards yet. Tap + to add your first card!')))
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final cubit = context.read<CardsListViewCubit>();
                      final card = cubit.cards[index];
                      return _FlashCardTile(card: card, onDelete: () => cubit.deleteCard(card.id ?? ''));
                    }, childCount: context.read<CardsListViewCubit>().cards.length),
                  ),
                ),
            ],
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

class _FlashCardTile extends StatelessWidget {
  const _FlashCardTile({required this.card, required this.onDelete});

  final FlashCardDataModel card;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          card.questionText ?? 'No question',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: card.answerText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  card.answerText!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete Card'),
                content: const Text('Are you sure you want to delete this card?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      onDelete();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
