import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/flash_cards/subfeatures/cards_list_view/cubit/cards_list_view_cubit.dart';

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
                  child: Text(widget.deckName, style: context.headlineMedium),
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
