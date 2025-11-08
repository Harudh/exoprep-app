import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/common/ui/overlays/toast.dart';
import 'package:root/src/core/common/ui/widgets/theme_toggle_switch.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/extensions/app_scope_extension.dart';
import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/core/navigation/routes.dart';
import 'package:root/src/features/authentication/authentication_viewmodel.dart';
import 'package:root/src/features/authentication/widgets/login_form.dart';
import 'package:root/src/features/authentication/widgets/signup_form.dart';

part 'authentication_mixin.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> with AuthenticationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: ValueListenableBuilder<AuthenticationMode>(
            valueListenable: selectedMode,
            builder: (context, value, _) {
              return value == AuthenticationMode.login ? LoginForm(selectedMode: selectedMode) : SignUpForm(selectedMode: selectedMode);
            },
          ),
        ),
      ),
      floatingActionButton: const ThemeToggleSwitch(),
    );
  }
}
