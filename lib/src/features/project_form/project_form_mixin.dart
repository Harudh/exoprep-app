part of 'project_form_view.dart';

mixin ProductivityMixin on State<ProjectFormView> {
  final TextEditingController _projectNameController = TextEditingController();
  // Add this getter
  TextEditingController get projectNameController => _projectNameController;

  final viewModel = ProjectViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.projectFormState.addListener(
        _handleProductivityFormStateChange,
      );
    });

    _initService();
    super.initState();
  }

  Future<void> _initService() async {
    setState(() {});
  }

  Future<void> _handleProductivityFormStateChange() async {
    final state = viewModel.projectFormState.value;
    log('Status: ${state.status} - Data: ${state.data}');
    if (viewModel.projectFormState.value.status == ViewModelStatus.error) {
      AppToasts.showError(
        context,
        title: 'Login Failed',
        alignment: AlignmentGeometry.bottomCenter,
        description: '${viewModel.projectFormState.value.error}',
      );
    } else if (viewModel.projectFormState.value.status ==
        ViewModelStatus.success) {
      AppToasts.showError(
        context,
        title: 'Success',
        description: 'Successfuly added project',
      );
    }
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }
}
