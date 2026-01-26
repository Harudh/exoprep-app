part of "home_view.dart";

mixin HomeMixin on State<HomeView> {
  late HomeViewmodel _homeViewmodel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Move the assignment here. This method is safe for context lookups.
    _homeViewmodel = context.homeViewModel;
    // Keep the post-frame callback here for the initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeViewmodel.fetchDashboardData();
    });
  }

  @override
  void initState() {
    super.initState(); // Call super first
  }

  @override
  void dispose() {
    super.dispose();
  }
}
