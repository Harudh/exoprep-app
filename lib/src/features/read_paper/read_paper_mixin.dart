part of 'read_paper_view.dart';

mixin ReadPaperMixin on State<ReadPaperView> {
  late ReadPaperViewmodel _readPaperViewmodel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _readPaperViewmodel = ReadPaperViewmodel();
    // Keep the post-frame callback here for the initial fetch

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readPaperViewmodel.fetchANDFilterData(widget.paper.id);
    });
  }

  @override
  void initState() {
    _readPaperViewmodel = ReadPaperViewmodel();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
