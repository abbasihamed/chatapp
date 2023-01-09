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
    final formKey = useState(GlobalKey<FormState>());
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Your email address',
                  style: TextStyle(fontSize: 26),
                ),
                const SizedBox(height: 8),
                const Text(
                  """Please confirm your email address,\nYour email is username""",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: 350,
                    child: Form(
                      key: formKey.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: AuthTextField(
                        controller: controller,
                        labelText: 'Email Address',
                        hintText: 'example@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (_) {
                          if (formKey.value.currentState!.validate()) {
                            Get.find<AuthViewModel>()
                                .sendEmail(controller.text);
                            navKey.currentState!.push(
                              MaterialPageRoute(
                                builder: (context) => CodeVerifyScreen(
                                  email: controller.text,
                                ),
                              ),
                            );
                          }
                        },
                        validator: (_) => InputValidation.inputValidation
                            .emailValidation(controller.text),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (formKey.value.currentState!.validate()) {
              Get.find<AuthViewModel>().sendEmail(controller.text);
              navKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => CodeVerifyScreen(
                    email: controller.text,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
