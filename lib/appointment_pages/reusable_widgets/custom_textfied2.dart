import 'package:flutter/material.dart';

InputDecoration customDecoration2(IconData icons, String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    prefixIcon: Icon(icons),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Color(0xffffe89d),
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        // color: Colors.amber
        width: 1.5,
      ),
    ),
  );
}
