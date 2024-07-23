import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/sign_up_form.dart';
import '../utils/login_form.dart';

class LoginDialog extends StatefulWidget {
  final bool isCreatedAccountClicked;
  const LoginDialog({super.key, this.isCreatedAccountClicked = false});

  @override
  State<LoginDialog> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginDialog> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final GlobalKey<FormState>? globalKey = GlobalKey<FormState>();
  late var isCreatedAccountClicked = widget.isCreatedAccountClicked;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: isCreatedAccountClicked ? 440 : 400,
        width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isCreatedAccountClicked ? 'sign_up' : 'login',
              style: Theme.of(context).textTheme.headline5,
            ).tr(),
            const Expanded(child: SizedBox()),
            isCreatedAccountClicked
                ? SignUpForm(
                    formKey: globalKey,
                    ctx: context,
                    emailTextController: emailTextController,
                    passwordTextController: passwordTextController)
                : LoginForm(
                    formKey: globalKey,
                    ctx: context,
                    emailTextController: emailTextController,
                    passwordTextController: passwordTextController),
            const Expanded(child: SizedBox()),
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    isCreatedAccountClicked ^= true;
                  });
                },
                icon: Icon(
                  Icons.portrait_rounded,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
                label: Text(
                  isCreatedAccountClicked
                      ? 'Already have an account?'
                      : 'Create Account',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                ),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic))),
          ],
        ),
      ),
    );
  }
}
