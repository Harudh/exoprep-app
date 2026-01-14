part of 'attempt_paper_view.dart';

mixin AttemptPaperMixin on State<AttemptPaperView> {
  late AttemptPaperViewModel _viewModel;

  AttemptPaperViewModel get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AttemptPaperViewModel();

    // Fetch data after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPaperData();
    });
  }

  Future<void> _fetchPaperData() async {
    await _viewModel.fetchPaperData(examID: widget.paper.exam.id, paperID: widget.paper.id);
  }

  Future<void> onRefresh() async {
    await _viewModel.refreshPaperData(examID: widget.paper.exam.id, paperID: widget.paper.id);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
