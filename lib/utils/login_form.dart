import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Form(
      key: _globalKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: isValidEmail,
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
                  FocusScope.of(context).requestFocus(_submitFocusNode),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              focusNode: _submitFocusNode,
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: Theme.of(context).bottomAppBarColor,
                  textStyle: TextStyle(fontSize: 18)),
              onPressed: () {
                if (_globalKey!.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  // var future = FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //         email: _emailTextController.text,
                  //         password: _passwordTextController.text)
                  //     .then((value) => Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             settings: RouteSettings(name: MainPage.routeName),
                  //             builder: (ctx) => MainPage())))
                  //     .onError<FirebaseAuthException>(
                  // (error, _) {
                  //   final message = error.message ??
                  //       'An error occured, please check your credentials!';
                  // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                  //     content: Text(
                  //   message,
                  //   style: const TextStyle(
                  //     color: Colors.red,
                  //     fontSize: 20,
                  //   ),
                  // )));
                  // },
                }
              },
              child: Text('login').tr())
        ],
      ),
    );
  }
}
