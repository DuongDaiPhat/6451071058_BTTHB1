import 'package:btthb1/di/injection_container.dart';
import 'package:btthb1/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:btthb1/core/theme/app_colors.dart';
import 'package:btthb1/shared/widgets/custom_button.dart';
import 'package:btthb1/shared/widgets/custom_text_field.dart';
import 'package:btthb1/core/routes/app_route.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Lấy ra UseCase từ GetIt (DI)
    final loginUseCase = sl<LoginUseCase>();

    // Gọi hàm call thông qua UseCase (truyền email và password thực tế từ TextField)
    final result = await loginUseCase.call(
      LoginParams(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );

    // result là Either<Failure, UserEntity>. fold giúp rẽ nhánh Thành công/Thất bại
    result.fold(
      (failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (userEntity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Chào mừng ${userEntity.email}")),
        );
        // Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit, sed do eiusmod tempor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textBody,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 50),

                // Form Fields
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Brandonelouis@gmail.com',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: '••••••••••••',
                  isPassword: _obscurePassword,
                  trailingIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textHint,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Remember Me & Forgot Password Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _rememberMe
                                  ? AppColors.primaryDark
                                  : AppColors.checkboxLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: _rememberMe
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            color: AppColors.textHint,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.forgotPassword);
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Buttons
                CustomButton(
                  text: 'LOGIN',
                  backgroundColor: AppColors.primaryDark,
                  textColor: AppColors.white,
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'SIGN IN WITH GOOGLE',
                  backgroundColor: AppColors.btnGoogleBackground,
                  textColor: AppColors.primaryDark,
                  // Note: Replace the Container below with your actual Google Logo asset
                  // Image.asset('assets/icons/google.png', height: 24)
                  leadingIcon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/google.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  onPressed: () {
                    // TODO: Handle Google Sign In
                  },
                ),

                const SizedBox(height: 30),

                // Footer
                RichText(
                  text: TextSpan(
                    text: "You don't have an account yet? ",
                    style: const TextStyle(
                      color: AppColors.textBody,
                      fontSize: 14,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.signUp);
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppColors.actionOrange,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
