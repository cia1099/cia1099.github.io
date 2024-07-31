import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'input_decorator.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    GlobalKey<FormState>? formKey,
    required this.ctx,
  })  : _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _globalKey = formKey,
        super(key: key);

  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final GlobalKey<FormState>? _globalKey;
  final _passwordFocusNode = FocusNode();
  final _createFocusNode = FocusNode();
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    String? emailAlreadyExist;
    return Form(
      key: _globalKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Please enter a valid email and password that is arbitrary characters.',
            style: Theme.of(context).primaryTextTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (email) => isValidEmail(email) ?? emailAlreadyExist,
              controller: _emailTextController,
              decoration:
                  buildInputDecoration(context, 'email', 'john@gmail.com'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocusNode),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                return value!.isEmpty ? 'Please enter a password' : null;
              },
              obscureText: true,
              controller: _passwordTextController,
              decoration: buildInputDecoration(context, 'password', ''),
              textInputAction: TextInputAction.next,
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_createFocusNode),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              focusNode: _createFocusNode,
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: Theme.of(context).bottomAppBarColor,
                  textStyle: TextStyle(fontSize: 18)),
              onPressed: () async {
                if (_globalKey!.currentState!.validate()) return;
                final url = Uri.parse('${MyApp.monitorUrl}/register');
                final res = await http.post(url,
                    body: jsonEncode({
                      'email': _emailTextController.text,
                      'password': _passwordTextController.text
                    }),
                    headers: {'Content-Type': 'application/json'});
                final msg = json.decode(res.body)['detail'];
                switch (res.statusCode) {
                  case 400:
                    emailAlreadyExist = msg;
                    break;
                }
                if (emailAlreadyExist != null) {
                  _globalKey.currentState!.validate();
                  emailAlreadyExist = null;
                }
              },
              child: Text('sign_up').tr())
        ],
      ),
    );
  }
}
