part of 'exam_analytics_view.dart';

mixin ExamAnalyticsMixin on State<ExamAnalyticsView> {
  late ExamAnalyticsViewmodel _examAnalyticsViewmodel;
  late ScrollController scrollController;

  @override
  void initState() {
    _examAnalyticsViewmodel = ExamAnalyticsViewmodel();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _examAnalyticsViewmodel.fetchAnalyticsData(examID: widget.examId);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }
}
