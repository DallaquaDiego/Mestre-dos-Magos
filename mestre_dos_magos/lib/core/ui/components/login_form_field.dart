import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/custom_colors.dart';

class LoginFormField extends StatefulWidget {
  final bool secret;
  final List<TextInputFormatter>? input;
  final String? error;
  final String? initialvalue;
  final onChanged;
  final String? suffixText;
  final Function? set_visible;
  final bool visible;
  final Key? keyy;
  final TextInputType? typeKeyboard;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final String? labelText;
  final String? hintText;

  LoginFormField({
    Key? key,
    this.secret = false,
    this.input,
    required this.error,
    this.initialvalue,
    this.onChanged,
    this.suffixText,
    this.set_visible = null,
    this.visible = false,
    this.keyy,
    this.typeKeyboard,
    this.textInputAction,
    this.onFieldSubmitted,
    this.controller,
    this.textAlign,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      color: CustomColors.white_mist,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        textAlign: widget.textAlign ?? TextAlign.start,
        controller: widget.controller,
        cursorColor: CustomColors.dragon_blood,
        keyboardType: widget.typeKeyboard,
        key: widget.keyy,
        initialValue: widget.initialvalue,
        onChanged: widget.onChanged,
        inputFormatters: widget.input,
        obscureText: widget.secret ? widget.visible : false,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: CustomColors.dragon_blood, fontSize: 16),
          labelStyle: const TextStyle(color: CustomColors.dragon_blood),
          fillColor: CustomColors.ancient_gold.withOpacity(0.2),
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
          errorText: widget.error,
          suffixIcon: widget.secret ? IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              widget.set_visible!();
            },
            icon: Icon(
              widget.visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: CustomColors.dragon_blood.withOpacity(0.6),
            ),
          ) : null,
        ),
      ),
    );
  }
}
