import 'package:flutter/material.dart';

Widget textfeild(
    String text1,
    String text2,
    IconButton iconbutton,
    TextInputType type,
    TextEditingController controller,
    String validationText) {
  return TextFormField(
    style: const TextStyle(
      color: Colors.black87,
    ),
    keyboardType: type,
    /////////////////////obscureText: true,
    controller: controller,
    validator: (String? value) {
      if (value!.isEmpty) {
        return validationText;
      }
      return null;
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.black)),
      labelText: text1,
      hintText: text2,
      suffixIcon: iconbutton,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
    ),
  );
}
