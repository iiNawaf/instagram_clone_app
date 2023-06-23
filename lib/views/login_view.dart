import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/viewmodels/login_viewmodel.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_button.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_textfield.dart';

final loginViewModelProvider = ChangeNotifierProvider((ref) {
  return LoginViewModel(ref);
});

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final isLoading = useState(false);
    final isError = useState(false);
    final isButtonEnabled = useState(false);

    useEffect(() {
      void listener() {
        isButtonEnabled.value = emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty;
      }

      emailController.addListener(listener);
      passwordController.addListener(listener);

      return () {
        emailController.removeListener(listener);
        passwordController.removeListener(listener);
      };
    });

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
          child: CustomAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Constants.logoText, height: 60),
                const SizedBox(height: 35),
                CustomTextField(
                  isError: isError.value,
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  suffixIcon: GestureDetector(
                    onTap: () => emailController.clear(),
                    child: const Icon(Icons.cancel_outlined,
                        size: AppDimensions.iconSmall),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    isError: isError.value,
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    suffixIcon: const Icon(Icons.visibility_off_outlined)),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Text("Forgot password?",
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  isLoading: isLoading.value,
                  opacity: isButtonEnabled.value ? 1 : 0.5,
                  title: "Log in",
                  click: () async {
                    isError.value = false;
                    if (isButtonEnabled.value) {
                      isLoading.value = true;
                      final result = await ref.read(loginViewModelProvider).login(
                          emailController.text, passwordController.text);
                      if (!result) {
                        isError.value = true;
                      }
                    } else {
                      isLoading.value = false;
                      print("fields are empty");
                    }
                    isLoading.value = false;
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderColor))),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ",
                    style: Theme.of(context).textTheme.bodySmall),
                GestureDetector(
                  onTap: () =>
                      context.pushNamed(AppRoutes.signUpRouteUsernameName),
                  child: Text("Sign Up.",
                      style: Theme.of(context).textTheme.labelSmall),
                )
              ],
            ),
          ),
        ));
  }
}
