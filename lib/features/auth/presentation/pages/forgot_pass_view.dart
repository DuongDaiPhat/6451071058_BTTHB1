import 'package:btthb1/core/theme/app_colors.dart';
import 'package:btthb1/shared/widgets/custom_button.dart';
import 'package:btthb1/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:btthb1/core/routes/app_route.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'To reset your password, you need your email or mobile number that can be authenticated',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Minh họa Illustration ở đây
              Image.asset('assets/images/forgotPassLogo.png', height: 120),
              const SizedBox(height: 30),
              const CustomTextField(
                label: 'Email',
                hintText: 'Brandonelouis@gmail.com',
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'RESET PASSWORD',
                backgroundColor: AppColors.primaryDark,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.checkEmail);
                },
              ),
              const SizedBox(height: 15),
              CustomButton(
                text: 'BACK TO LOGIN',
                backgroundColor: AppColors.primaryLight,
                textColor: AppColors.primaryDark,
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
