import 'package:flutter/material.dart';
import 'package:btthb1/features/auth/presentation/pages/splash_view.dart';
import 'package:btthb1/features/auth/presentation/pages/onboarding.dart';
import 'package:btthb1/features/auth/presentation/pages/login_view.dart';
import 'package:btthb1/features/auth/presentation/pages/sign_up_view.dart';
import 'package:btthb1/features/auth/presentation/pages/forgot_pass_view.dart';
import 'package:btthb1/features/auth/presentation/pages/check_email.dart';
import 'package:btthb1/features/auth/presentation/pages/success_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String checkEmail = '/checkEmail';
  static const String success = '/success';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashView(),
      onboarding: (context) => const OnboardingView(),
      login: (context) => const LoginView(),
      signUp: (context) => const SignUpView(),
      forgotPassword: (context) => const ForgotPasswordView(),
      checkEmail: (context) => const CheckEmailView(),
      success: (context) => const SuccessView(),
    };
  }
}
