import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/view_model/auth_view_model.dart';

import '../../core/constanst.dart';
import '../../helper/validation.dart';
import '../home/home_screen.dart';
import 'code_verify.dart';
import 'widgets/auth_text_field.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthViewModel());
    final controller = useTextEditingController();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final formKey = useState(GlobalKey<FormState>());
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your email address',
                style: theme.textTheme.bodyText1,
              ),
              const SizedBox(height: 8),
              Text(
                """
Please confirm your email address,
Your email is username
""",
                style: theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: size.width * 0.7,
                child: Form(
                  key: formKey.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: AuthTextField(
                    controller: controller,
                    theme: theme,
                    labelText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (_) => navKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    ),
                    validator: (_) => InputValidation.inputValidation
                        .emailValidation(controller.text),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.primaryColor,
          child: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (formKey.value.currentState!.validate()) {
              Get.find<AuthViewModel>().sendEmail(controller.text);
              navKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => const CodeVerifyScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
