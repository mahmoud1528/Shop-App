
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/core/shared/theme/controller/cubit.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final IconData prefix;
  final IconData? suffix;
  final Function()? onTap;
  final bool isPassword;
  final bool isUpperCase;
  final String text;
  final TextStyle? style;
  final Function()? onSuffixPressed;
  final Color? coloroftextfield;
  final Color? coloroftext;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;


  const MyFormField({
    super.key,
    required this.controller,
    required this.type,
    required this.prefix,
    this.onTap,
    this.isPassword = false,
    this.isUpperCase = true,
    required this.text,
    this.style,
    this.suffix,
    this.onSuffixPressed,
    this.coloroftext,
    this.coloroftextfield,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: ThemeModeCubit.get(context).isDark ? Colors.black : Colors.white),
      controller: controller,
      keyboardType:type,
      onTap: onTap,
      obscureText: isPassword,
      validator: validator,
      onChanged: onChanged ,
      decoration: InputDecoration(
        filled: true,
        fillColor: coloroftextfield,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide( // color of formfield
            color: ThemeModeCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide( // شكل الخط اللي بيظهر لما يتم الضغط على الحقل
            color: ThemeModeCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
          ),
        ),
        prefixIcon: Icon(
          prefix,
          color: coloroftext,
        ),
        label: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: style,
        ),
        suffixIcon:suffix != null ? IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(
            suffix,
            color: coloroftext,
          ),
        ) : null,
      ),

      cursorColor: coloroftext,

    );
  }
}
