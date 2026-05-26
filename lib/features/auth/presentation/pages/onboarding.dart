import 'package:flutter/material.dart';
import 'package:btthb1/core/theme/app_colors.dart';
import 'package:btthb1/core/routes/app_route.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: const Text('Jobspot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const Spacer(),
              Center(
                // Thay bằng Image.asset minh họa onboarding
                child: Image.asset('assets/images/dreamJobPage.png', height: 300),
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primaryDark, height: 1.1),
                  children: [
                    TextSpan(text: 'Find Your\n'),
                    TextSpan(text: 'Dream Job', style: TextStyle(color: AppColors.actionOrange, decoration: TextDecoration.underline)),
                    TextSpan(text: '\nHere!'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Explore all the most exciting job roles based\non your interest and study major.',
                style: TextStyle(color: AppColors.textBody, fontSize: 16),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: AppColors.primaryDark,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}