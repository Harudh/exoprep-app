part of 'exam_dashboard_view.dart';

mixin ExamDashboardMixin on State<ExamDashboardView> {
  late ExamDashboardViewModel _examDashboardViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _examDashboardViewModel = context.examDashboardViewModel;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _examDashboardViewModel.examID = widget.examID;
      _examDashboardViewModel.fetchDashboardData(examID: widget.examID);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
