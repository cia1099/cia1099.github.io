import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:portfolio/api/user_api.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/widgets/turnstile.dart';
import 'package:http/http.dart' as http;

import 'input_decorator.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required this.ctx,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    GlobalKey<FormState>? formKey,
  })  : _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _globalKey = formKey,
        super(key: key);

  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final GlobalKey<FormState>? _globalKey;
  final BuildContext ctx;
  final _passwordFocusNode = FocusNode();
  final _submitFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final turnstileToken = TextEditingController();
    String? emailNotFound, errorPassword;
    return Form(
      key: _globalKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (email) => isValidEmail(email) ?? emailNotFound,
              controller: _emailTextController,
              decoration: buildInputDecoration(
                context,
                'email',
                'john@gmail.com',
                suffixIcon: IconButton(
                    onPressed: () => _emailTextController.clear(),
                    icon: const Icon(CupertinoIcons.delete_left)),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocusNode),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a password' : errorPassword,
              obscureText: true,
              controller: _passwordTextController,
              decoration: buildInputDecoration(
                context,
                'password',
                '',
                suffixIcon: IconButton(
                    onPressed: () => _passwordTextController.clear(),
                    icon: const Icon(CupertinoIcons.delete_left)),
              ),
              textInputAction: TextInputAction.next,
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_submitFocusNode),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
            valueListenable: turnstileToken,
            builder: (context, value, child) => TextButton(
                focusNode: _submitFocusNode,
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: Theme.of(context).bottomAppBarColor,
                    textStyle: TextStyle(fontSize: 18)),
                onPressed: value.text.isEmpty
                    ? null
                    : () async {
                        if (!_globalKey!.currentState!.validate()) return;
                        final res = await UserAPI().login(
                            _emailTextController.text,
                            _passwordTextController.text,
                            turnstileToken.text);
                        final msg = json.decode(res.body)['detail'] as String?;
                        switch (res.statusCode) {
                          case 404:
                            emailNotFound = msg;
                            break;
                          case 403:
                            errorPassword = msg;
                            break;
                          case 202:
                            print("successful login to get access token");
                            Navigator.of(context).pop();
                            break;
                          default:
                            showToast(msg,
                                textStyle: TextStyle(
                                    color: Theme.of(context).errorColor),
                                context: context,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                position: StyledToastPosition.center);
                        }
                        if (emailNotFound != null || errorPassword != null) {
                          _globalKey.currentState!.validate();
                          emailNotFound = null;
                          errorPassword = null;
                        }
                      },
                child: child!),
            child: Text('login').tr(),
          ),
          TurnStileHtmlView(
              tokenFeedback: (token) => turnstileToken.text = token),
        ],
      ),
    );
  }
}
