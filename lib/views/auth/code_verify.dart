import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:my_chat_app/view_model/auth_view_model.dart';
import 'package:my_chat_app/views/logic/timer_controller.dart';

import '../../helper/validation.dart';
import 'widgets/auth_text_field.dart';

class CodeVerifyScreen extends HookWidget {
  final String email;
  const CodeVerifyScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                email,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(height: 8),
              const Text(
                """
We have sent the verification code to your email
Please enter it.
""",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Form(
                key: formKey.value,
                child: SizedBox(
                  width: 350,
                  child: AuthTextField(
                    controller: controller,
                    labelText: 'Code',
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    validator: (_) => InputValidation.inputValidation
                        .emptyValidation(controller.text),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GetBuilder<TimerController>(
                init: TimerController(),
                builder: (timer) {
                  if (timer.isTimerEnd) {
                    return TextButton(
                      onPressed: () {
                        Get.find<AuthViewModel>().sendEmail(email);
                        timer.startTimer();
                      },
                      child: const Text(
                        'Send again',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return Text(
                    '${timer.minutes} : ${timer.seconds}',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (formKey.value.currentState!.validate()) {
              Get.find<AuthViewModel>().sendVerifyCode(controller.text);
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ),
    );
  }
}
