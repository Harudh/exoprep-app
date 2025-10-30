part of 'productivity_view.dart';

mixin ProductivityMixin on State<ProductivityView> {
  late ProductivityViewModel _productivityViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productivityViewModel = context.productivityViewModel;
      _productivityViewModel.productivityState.addListener(
        _handleProductivityStateChange,
      );
    });
    super.initState();
  }

  Future<void> _handleProductivityStateChange() async {
    final state = context.productivityViewModel.productivityState.value;
    AppLogs.debug('Status: ${state.status} - Data: ${state.data}');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
