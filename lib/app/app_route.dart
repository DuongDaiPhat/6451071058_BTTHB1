import 'package:flutter/material.dart';
import '../views/Auth/splash_view.dart';
import '../views/Auth/onboarding.dart';
import '../views/Auth/login_view.dart';
import '../views/Auth/sign_up_view.dart';
import '../views/Auth/forgot_pass_view.dart';
import '../views/Auth/check_email.dart';
import '../views/Auth/success_view.dart';

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
