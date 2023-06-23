import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/viewmodels/sign_up_viewmodel.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_button.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_textfield.dart';

final signUpViewModelProvider = ChangeNotifierProvider((ref) {
  return SignUpViewModel();
});

class SignUpUsernameView extends HookConsumerWidget {
  const SignUpUsernameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final isButtonEnabled = useState(false);

    useEffect(() {
      void listener() {
        isButtonEnabled.value = emailController.text.isNotEmpty &&
            usernameController.text.isNotEmpty;
      }

      emailController.addListener(listener);
      usernameController.addListener(listener);

      return () {
        emailController.removeListener(listener);
        usernameController.removeListener(listener);
      };
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text("Create username",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                      right: AppDimensions.paddingLarge,
                      left: AppDimensions.paddingLarge),
                  child: Text(
                    "Pick a username for your new account. You can always change it later.",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  isError: false,
                  controller: emailController,
                  hintText: "Email address",
                  obscureText: false,
                  suffixIcon: GestureDetector(
                    onTap: () => emailController.clear(),
                    child: const Icon(Icons.cancel_outlined,
                        size: AppDimensions.iconSmall),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  isError: false,
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                  suffixIcon: GestureDetector(
                    onTap: () => usernameController.clear(),
                    child: const Icon(Icons.cancel_outlined,
                        size: AppDimensions.iconSmall),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  isLoading: false,
                  opacity: isButtonEnabled.value ? 1 : 0.5,
                  title: "Next",
                  click: () async {
                    if (isButtonEnabled.value) {
                      context.goNamed(AppRoutes.signUpRoutePasswordName,
                          queryParameters: {
                            'email': emailController.text,
                            'username': usernameController.text
                          });
                    } else {
                      print("Disabled Button");
                    }
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
