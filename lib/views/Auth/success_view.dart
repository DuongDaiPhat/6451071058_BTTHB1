import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
class SuccessView extends StatelessWidget {
  const SuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Successfully', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Your password has been updated, please change your password regularly to avoid this happening', textAlign: TextAlign.center),
            const SizedBox(height: 40),
            Image.asset('lib/assets/images/success.png', height: 150),
            const SizedBox(height: 40),
            CustomButton(text: 'CONTINUE', backgroundColor: AppColors.primaryDark, textColor: Colors.white, onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
            const SizedBox(height: 15),
            CustomButton(text: 'BACK TO LOGIN', backgroundColor: AppColors.primaryLight, textColor: AppColors.primaryDark, onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
          ],
        ),
      ),
    );
  }
}