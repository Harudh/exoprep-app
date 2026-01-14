part of '../exam_dashboard_view.dart';

class PracticePapersSection extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const PracticePapersSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
            child: Text(
              "Practice Papers",
              style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
            ),
          ),
          const SizedBox(height: 12),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                _PracticePapersTabBar(),
                const SizedBox(height: 12),
                _PracticePapersTabView(viewModel: viewModel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticePapersTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: context.isDarkMode ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: context.bodyMedium!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3),
          tabs: const [
            Tab(text: 'PYQ'),
            Tab(text: 'Mock Tests'),
          ],
        ),
      ),
    );
  }
}

class _PracticePapersTabView extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const _PracticePapersTabView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: TabBarView(
        children: [
          _PYQTab(viewModel: viewModel),
          _MockTestsTab(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _PYQTab extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const _PYQTab({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState>(
      valueListenable: viewModel.pyqState,
      builder: (context, state, child) {
        if (state.status == ViewModelStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ViewModelStatus.error) {
          return _PapersErrorWidget(
            message: 'Failed to load PYQ papers',
            onRetry: () => viewModel.refreshPYQPapers(context.examDashboardViewModel.examID),
          );
        }

        final papers = state.data ?? [];
        if (papers.isEmpty) {
          return const Center(child: Text('No PYQ papers available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
          itemCount: papers.length,
          itemBuilder: (context, index) => _PaperCard(paper: papers[index]),
        );
      },
    );
  }
}

class _MockTestsTab extends StatelessWidget {
  final ExamDashboardViewModel viewModel;

  const _MockTestsTab({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ViewModelState>(
      valueListenable: viewModel.mockTestState,
      builder: (context, state, child) {
        if (state.status == ViewModelStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ViewModelStatus.error) {
          return _PapersErrorWidget(
            message: 'Failed to load mock tests',
            onRetry: () => viewModel.refreshMockTests(context.examDashboardViewModel.examID),
          );
        }

        final papers = state.data ?? [];
        if (papers.isEmpty) {
          return const Center(child: Text('No mock tests available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: ExamDashboardView.horizontalPadding),
          itemBuilder: (context, index) => _PaperCard(paper: papers[index]),
          itemCount: papers.length,
        );
      },
    );
  }
}

class _PaperCard extends StatelessWidget {
  final Paper paper;

  const _PaperCard({required this.paper});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPaperOptionsDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paper.name, style: context.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.3)),
                  const SizedBox(height: 4),
                  Text(paper.description, style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  void _showPaperOptionsDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _PaperOptionsDialog(paper: paper);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}

class _PaperOptionsDialog extends StatelessWidget {
  final Paper paper;

  const _PaperOptionsDialog({required this.paper});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    paper.name,
                    style: context.titleMedium!.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    paper.description,
                    style: context.bodySmall!.copyWith(color: Colors.grey.shade600, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _DialogOptionButton(
                    icon: Icons.visibility_outlined,
                    label: 'View Paper',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoute.readPaper.path, extra: paper);
                    },
                  ),
                  const SizedBox(height: 12),
                  _DialogOptionButton(
                    icon: Icons.edit_note_outlined,
                    label: 'Attempt Paper',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoute.instructions.path, extra: paper);
                    },
                    isPrimary: true,
                  ),
                ],
              ),
              Positioned(
                top: -12,
                right: -12,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                    icon: Icon(Icons.close, color: context.isDarkMode ? Colors.white : Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _DialogOptionButton({required this.icon, required this.label, required this.onTap, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isPrimary ? context.colorScheme.primary : (context.isDarkMode ? Colors.grey.shade900 : null),
          border: !isPrimary ? Border.all(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isPrimary ? Colors.white : (context.isDarkMode ? Colors.white : Colors.black87), size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: context.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
                color: isPrimary ? Colors.white : (context.isDarkMode ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PapersErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _PapersErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 48),
          const SizedBox(height: 16),
          Text(message, style: context.bodyMedium!.copyWith(color: Colors.red.shade400)),
          const SizedBox(height: 16),
          ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ],
      ),
    );
  }
}
