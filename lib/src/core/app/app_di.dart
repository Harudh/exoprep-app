import 'package:root/src/features/authentication/authentication_viewmodel.dart';
import 'package:root/src/features/exam_dashboard/exam_dashboard_viewmodel.dart';
import 'package:root/src/features/home/home_viewmodel.dart';
import 'package:root/src/features/productivity/productivity_viewmodel.dart';
import 'package:root/src/repositories/productivity_project_repository.dart';
import 'package:root/src/repositories/authentication_repository.dart';
import 'package:root/src/core/common/listeners/auth_listener.dart';
import 'package:root/src/repositories/papers_repository.dart';
import 'package:root/src/services/firebase_auth_service.dart';
import 'package:root/src/services/productivity_service.dart';
import 'package:root/src/repositories/user_repository.dart';
import 'package:root/src/services/papers_services.dart';
import 'package:root/src/core/app/app_scope.dart';
import 'package:flutter/material.dart';

class AppDI extends StatelessWidget {
  final Widget child;

  const AppDI({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    //!----- Services -----//
    final firebaseAuthService = FirebaseAuthService();
    final productivityProjectService = ProductivityService();
    final papersService = PapersService();

    //!----- Repositories -----//
    final authRepository = AuthenticationRepository(authService: firebaseAuthService);
    final productivityProjectRepository = ProductivityProjectRepository(productivityProjectService: productivityProjectService);
    final papersRepository = PapersRepository(papersService: papersService);
    final userRepository = UserRepository();

    //!----- ViewModels -----//
    final authViewModel = AuthenticationViewModel(authRepository: authRepository, userRepository: userRepository);
    final productivityViewModel = ProductivityViewModel(productivityRepository: productivityProjectRepository);
    final examDashboardViewModel = ExamDashboardViewModel(papersRepository: papersRepository);
    final homeViewModel = HomeViewmodel();

    return AppScope(
      authViewModel: authViewModel,
      productivityViewModel: productivityViewModel,
      examDashboardViewModel: examDashboardViewModel,
      homeViewModel: homeViewModel,
      child: AuthListener(child: child),
    );
  }
}
