import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
    BuildContext context, String label, String hint) {
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
      labelText: label,
      hintText: hint);
}
