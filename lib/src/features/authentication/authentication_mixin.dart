part of 'authentication_view.dart';

mixin AuthenticationMixin on State<AuthenticationView> {
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final GlobalKey<FormState> signupFormKey = GlobalKey();

  ValueNotifier<AuthenticationMode> selectedMode = ValueNotifier(AuthenticationMode.login);

  late AuthenticationViewModel _authViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authViewModel = context.authViewModel;
      _authViewModel.authState.addListener(_handleAuthStateChange);
    });
  }

  Future<void> _handleAuthStateChange() async {
    final state = context.authViewModel.authState.value;
    AppLogs.debug('Status: ${state.status} - Data: ${state.data}');

    if (_authViewModel.authState.value.status == ViewModelStatus.success &&
        _authViewModel.authState.value.type == AuthSuccessType.signup.toString()) {
      AppToasts.showSuccess(
        context,
        title: 'Account Created',
        description: 'Your account has been successfully created.',
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      context.go(AppRoute.selectExams.path);
    } else if (_authViewModel.authState.value.status == ViewModelStatus.error &&
        _authViewModel.authState.value.type == AuthErrorType.signup.toString()) {
      AppToasts.showError(
        context,
        title: 'Sign-up Failed',
        description: '${_authViewModel.authState.value.error}',
      );
    } else if (_authViewModel.authState.value.status == ViewModelStatus.success &&
        _authViewModel.authState.value.type == AuthSuccessType.login.toString()) {
      AppToasts.showSuccess(
        context,
        title: 'Welcome Back',
        description: 'You have successfully signed in.',
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      context.go(AppRoute.home.path);
    } else if (_authViewModel.authState.value.status == ViewModelStatus.error &&
        _authViewModel.authState.value.type == AuthErrorType.login.toString()) {
      AppToasts.showError(
        context,
        title: 'Login Failed',
        description: '${_authViewModel.authState.value.error}',
      );
    } else if (_authViewModel.authState.value.status == ViewModelStatus.success &&
        _authViewModel.authState.value.type == AuthSuccessType.google.toString()) {
      AppToasts.showSuccess(
        context,
        title: 'Signed In',
        description: 'Google authentication completed successfully.',
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      if(_authViewModel.authState.value.data == true)  {
        context.go(AppRoute.selectExams.path);
      } else{
        context.go(AppRoute.home.path);
      }
    } else if (_authViewModel.authState.value.status == ViewModelStatus.error &&
        _authViewModel.authState.value.type == AuthSuccessType.google.toString()) {
      AppToasts.showError(
        context,
        title: 'Google Authentication Failed',
        description: '${_authViewModel.authState.value.error}',
      );
    } else if (_authViewModel.authState.value.status == ViewModelStatus.idle &&
        _authViewModel.authState.value.data == AuthSuccessType.resetPassword.toString()) {
      AppToasts.showSuccess(
        context,
        title: 'Email Sent',
        description: 'We’ve sent a reset link to your email address.',
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      context.pop();
    }
  }

  @override
  void dispose() {
    _authViewModel.authState.removeListener(_handleAuthStateChange);
    super.dispose();
  }
}
