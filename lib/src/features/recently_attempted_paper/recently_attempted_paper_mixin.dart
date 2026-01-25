part of 'recently_attempted_paper_view.dart';

mixin RecentlyAttemptedPaperMixin on State<RecentlyAttemptedPaperView> {
  late RecentlyAttemptedPaperViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RecentlyAttemptedPaperViewModel();
    viewModel.fetchAllData(attemptedPaperId: widget.recentlyAttemptedPaperId, paperId: widget.paperId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${secs}s';
    } else if (minutes > 0) {
      return '${minutes}m ${secs}s';
    } else {
      return '${secs}s';
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color getScoreColor(double percentage) {
    if (percentage >= 75) return Colors.green;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }
}
