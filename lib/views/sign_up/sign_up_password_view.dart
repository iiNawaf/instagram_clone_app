import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/viewmodels/sign_up/sign_up_viewmodel.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_button.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_textfield.dart';

final signUpViewModelProvider = ChangeNotifierProvider((ref) {
  return SignUpViewModel(ref);
});

class SignUpPasswordView extends HookConsumerWidget {
  final String email;
  final String username;
  const SignUpPasswordView({super.key, required this.email, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController();
    final isButtonEnabled = useState(false);
    final isLoading = useState(false);
    final isError = useState(false);
    final errorMsg = useState("");

    useEffect(() {
      void listener() {
        isButtonEnabled.value = passwordController.text.isNotEmpty;
      }

      passwordController.addListener(listener);

      return () {
        passwordController.removeListener(listener);
      };
    });

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text("Create a password",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                      right: AppDimensions.paddingLarge,
                      left: AppDimensions.paddingLarge),
                  child: Text(
                    "We can remember the password, so you won't need to enter it on your iCloud devices.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  type: "auth",
                  controller: passwordController,
                  hintText: "Password",
                  isError: isError.value,
                  obscureText: true,
                  suffixIcon: GestureDetector(
                    onTap: () => passwordController.clear(),
                    child: const Icon(Icons.cancel_outlined,
                        size: AppDimensions.iconSmall),
                  ),
                ),
                isError.value
                    ? Row(
                        children: [
                          Text(errorMsg.value, style: Constants.errorMsgStyle),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 20),
                CustomButton(
                  isLoading: isLoading.value,
                  opacity: isButtonEnabled.value ? 1 : 0.5,
                  title: "Next",
                  click: () async {
                    if (isButtonEnabled.value) {
                      isLoading.value = true;
                      isError.value = false;
                      errorMsg.value = "";
                      // start sign up
                      final result = await ref
                          .read(signUpViewModelProvider.notifier)
                          .signUp(email, passwordController.text, username);
                      // context.goNamed(AppRoutes.appManagerRouteName);
                      if (!result) {
                        isError.value = true;
                        errorMsg.value =
                            "There was an error creating your account.";
                      }
                    } else {
                      isLoading.value = false;
                      print("nope");
                    }
                    isLoading.value = false;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
