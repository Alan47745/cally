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
  Color? hintColor,
  String? fontFamily = 'Poppins Regular',
  Widget? label,
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(15.0)),
  // BorderRadius enabledBorderRadius =
  //     const BorderRadius.all(Radius.circular(15.0)),
  // BorderRadius focusedBorderRadius =
  //     const BorderRadius.all(Radius.circular(15.0)),
  // BorderRadius errorBorderRadius =
  //     const BorderRadius.all(Radius.circular(15.0)),
  // BorderRadius errorFocusedBorderRadius =
  //     const BorderRadius.all(Radius.circular(15.0)),
  // BorderRadius disabledBorderRadius =
  //     const BorderRadius.all(Radius.circular(15.0)),
  BorderSide enabledBorderSide = const BorderSide(color: Colors.grey),
  BorderSide borderSide = const BorderSide(color: Colors.red),
  BorderSide focusedBorderSide = const BorderSide(color: primaryPurple),
  Widget? suffixIcon,
  Widget? prefixIcon,
  required BuildContext context,
  TextAlign textAlign = TextAlign.center,
}) {
  // final themeProvider = Provider.of<ThemeProvider>(context);
  return SizedBox(
    height: 50.0,
    child: TextFormField(
      controller: controller,
      validator: validator,
      cursorWidth: 0.5,
      cursorColor: primaryPurple,
      textAlign: textAlign,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: const TextStyle(
        height: 1.0,
        fontSize: 15.0,
        fontFamily: 'Poppins Regular',
      ),
      decoration: InputDecoration(
        
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: label,
        filled: filled,
        fillColor: fillColor,
        errorStyle: const TextStyle(
          fontSize: 0.0,
          height: 0.0,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 15.0,
          fontFamily: fontFamily,
          color: hintColor,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
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
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: focusedBorderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: enabledBorderSide,
        ),
      ),
    ),
  );
}
