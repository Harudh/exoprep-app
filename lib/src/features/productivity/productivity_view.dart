import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/extensions/context_extension.dart';

import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/productivity/productivity_viewmodel.dart';
import 'package:root/src/features/productivity/widgets/horizontal_date_picker.dart';
import 'package:root/src/features/productivity/widgets/project_list_tile.dart';

part 'productivity_mixin.dart';

class ProductivityView extends StatefulWidget {
  const ProductivityView({super.key});

  @override
  State<ProductivityView> createState() => _ProductivityViewState();
}

class _ProductivityViewState extends State<ProductivityView>
    with ProductivityMixin {
  @override
  Widget build(BuildContext context) {
    // final productivityViewModel = context.productivityViewModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Productivity',
          style: context.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Settings action
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Horizontal Date Picker
            SliverToBoxAdapter(
              child: HorizontalDatePicker(
                onDateSelected: (value) {
                  //!TODO: Implement the UI Change
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // "Your Projects" Title
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Your Projects',
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Project List Tile
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(child: ProjectListTile()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(22),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          context.pushNamed(AppRoute.createProjectForm.name);
        },
      ),
      // floatingActionButton: const ThemeToggleSwitch(),
    );
  }
}
