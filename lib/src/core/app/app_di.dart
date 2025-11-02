import 'package:flutter/material.dart';
import 'package:root/src/core/app/app_scope.dart';
import 'package:root/src/core/common/listeners/auth_listener.dart';
import 'package:root/src/features/authentication/authentication_viewmodel.dart';
import 'package:root/src/features/productivity/productivity_viewmodel.dart';
import 'package:root/src/repositories/authentication_repository.dart';
import 'package:root/src/repositories/productivity_project_repository.dart';
import 'package:root/src/repositories/user_repository.dart';
import 'package:root/src/services/firebase_auth_service.dart';
import 'package:root/src/services/productivity_service.dart';

class AppDI extends StatelessWidget {
  final Widget child;

  const AppDI({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    //!----- Services -----//
    final firebaseAuthService = FirebaseAuthService();
    final productivityProjectService = ProductivityService();

    //!----- Repositories -----//
    final authRepository = AuthenticationRepository(
      authService: firebaseAuthService,
    );
    final productivityProjectRepository = ProductivityProjectRepository(
      productivityProjectService: productivityProjectService,
    );

    final userRepository = UserRepository();

    //!----- ViewModels -----//
    final authViewModel = AuthenticationViewModel(
      authRepository: authRepository,
      userRepository: userRepository,
    );

    final productivityViewModel = ProductivityViewModel(
      productivityRepository: productivityProjectRepository,
    );

    return AppScope(
      authViewModel: authViewModel,
      productivityViewModel: productivityViewModel,
      child: AuthListener(child: child),
    );
  }
}
