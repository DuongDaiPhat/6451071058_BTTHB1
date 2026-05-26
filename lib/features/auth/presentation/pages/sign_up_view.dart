import 'package:btthb1/core/theme/app_colors.dart';
import 'package:btthb1/di/injection_container.dart';
import 'package:btthb1/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:btthb1/shared/widgets/custom_button.dart';
import 'package:btthb1/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:btthb1/core/routes/app_route.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _rememberMe = false;
  
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    // Lấy ra UseCase từ GetIt (DI)
    final signUpUseCase = sl<SignUpUseCase>();

    final result = await signUpUseCase.call(
      SignUpParams(
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Đăng ký thành công")));
        Navigator.pushNamed(context, AppRoutes.login);
        // Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing\nelit, sed do eiusmod tempor',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _fullNameController,
                label: 'Full name',
                hintText: 'Brandon Louis',
              ),
              const SizedBox(height: 20),
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
                isPassword: true,
              ),
              const SizedBox(height: 40),
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
              CustomButton(
                text: 'SIGN UP',
                backgroundColor: AppColors.primaryDark,
                textColor: AppColors.white,
                onPressed: _handleSignUp,
              ),
              const SizedBox(height: 15),
              CustomButton(
                text: 'SIGN UP WITH GOOGLE',
                backgroundColor: AppColors
                    .primaryLight, // Dùng màu nhạt cho Google ở trang này
                textColor: AppColors.primaryDark,
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
