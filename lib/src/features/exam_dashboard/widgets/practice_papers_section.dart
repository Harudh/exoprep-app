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
    return Container(
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
