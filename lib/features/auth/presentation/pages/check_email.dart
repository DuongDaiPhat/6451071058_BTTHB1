import 'package:flutter/material.dart';
import 'package:btthb1/core/theme/app_colors.dart';
import 'package:btthb1/shared/widgets/custom_button.dart';
import 'package:btthb1/core/routes/app_route.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Check Your Email',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We have sent a password reset link to your email address.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Image.asset('assets/images/checkyouremail.png', height: 150),
            const SizedBox(height: 40),
            CustomButton(
              text: 'OPEN YOUR EMAIL',
              backgroundColor: AppColors.primaryDark,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.success);
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: 'BACK TO LOGIN',
              backgroundColor: AppColors.primaryLight,
              textColor: AppColors.primaryDark,
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: "You haven't received the email? ",
                style: const TextStyle(color: AppColors.textBody, fontSize: 14),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      },
                      child: const Text(
                        'Resend',
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
          ],
        ),
      ),
    );
  }
}
