import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Constants.logoText, height: 60),
            const SizedBox(height: 35),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.inputBgColor,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                border: Border.all(color: AppColors.borderColor)
              ),
              child: Center(
                child: CustomTextField(
                  hintText: "Phone number, username or email",
                  obscureText: false,
                )
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.inputBgColor,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
                border: Border.all(color: AppColors.borderColor)
              ),
              child: Center(
                child: CustomTextField(
                  hintText: "Password",
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off_outlined)
                )
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text("Forgot password?", style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium)
              ),
              child: Center(
                child: Text("Log in", style: Theme.of(context).textTheme.titleSmall,),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? ", style: Theme.of(context).textTheme.bodySmall),
            GestureDetector(
              onTap: () => context.go('/login/sign_up'),
              child: Text("Sign Up.", style: Theme.of(context).textTheme.labelSmall),
            )
          ],
        ),
      )
    );
  }
}
