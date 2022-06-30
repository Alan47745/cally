// ignore_for_file: non_constant_identifier_names

import 'package:cally/utils/constant.dart';
import 'package:flutter/material.dart';

Widget CustomTextFormField({
  String? hintText,
  String? Function(String?)? validator,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  TextEditingController? controller,
  bool? filled,
  Color? fillColor,
}) {
  return SizedBox(
    height: 50.0,
    child: TextFormField(
      controller: controller,
      validator: validator,
      cursorWidth: 0.5,
      cursorColor: primaryPurple,
      textAlign: TextAlign.center,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: const TextStyle(
        height: 1.0,
        fontSize: 15.0,
        fontFamily: 'Poppins Regular',
      ),
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        errorStyle: const TextStyle(
          fontSize: 0.0,
          height: 0.0,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 15.0,
          fontFamily: 'Poppins Regular',
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: primaryPurple,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
  );
}
