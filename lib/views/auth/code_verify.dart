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
                style: theme.textTheme.bodyText1,
              ),
              const SizedBox(height: 8),
              Text(
                """
We have sent the verification code to your email
Please enter it.
""",
                style: theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Form(
                key: formKey.value,
                child: SizedBox(
                  width: 400,
                  child: AuthTextField(
                    controller: controller,
                    theme: theme,
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
                      child: Text(
                        'Send again',
                        style: theme.textTheme.caption!
                            .copyWith(color: theme.primaryColor),
                      ),
                    );
                  }
                  return Text(
                    '${timer.minutes} : ${timer.seconds}',
                    style: theme.textTheme.caption,
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.primaryColor,
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
