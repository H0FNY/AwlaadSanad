import 'package:flutter/material.dart';

import 'colors.dart';

Widget CustomTextFormField({
  String? Function(String?)? validator,
  Function()? onTap,
  TextEditingController? controller,
  void Function(String)? onchange,
  TextInputType keyboardType = TextInputType.text,
  bool hide = false,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  String? hintText,
  String? initial,
  int maxLines=1,
  bool readOnly=false,
  Function(String?)? onSubmit,
  TextAlign textAlign=TextAlign.center,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onchange,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: hide,
      cursorColor: mainColor,
      textAlign: textAlign,
      style: const TextStyle(color: mainColor, fontFamily: "Cairo",fontSize: 15),
      initialValue: initial,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
        hintText: hintText,
        hintStyle: const TextStyle(color: mainColor),
        filled: true,
        fillColor: whiteColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: mainColor,
        labelStyle: const TextStyle(
          color: mainColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainColor),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainColor),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
