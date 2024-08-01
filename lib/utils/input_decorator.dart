import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
    BuildContext context, String label, String hint,
    {Widget? suffixIcon}) {
  return InputDecoration(
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.blue)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
          color: Theme.of(context).textTheme.subtitle1!.color!, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Theme.of(context).errorColor, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Theme.of(context).errorColor)),
    labelText: label,
    labelStyle: Theme.of(context).primaryTextTheme.subtitle2,
    hintText: hint,
    errorMaxLines: 3,
    suffixIcon: suffixIcon,
  );
}

String? isValidEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Please enter an email';
  }
  // 电子邮件正则表达式
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(email)) {
    return 'Invalid email address';
  }
  return null;
}

String? isValidPassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter a password';
  }
  // 密码正则表达式：密码至少8位数，至少一个大写字母，至少一个数字和至少一个特殊符号
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );
  if (!passwordRegex.hasMatch(password)) {
    return 'Password must at least 8 digits, at least one uppercase letter, at least one number and at least one special character';
  }
  return null;
}
