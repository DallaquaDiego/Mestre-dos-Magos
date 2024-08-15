import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';

class TitleTextForm extends StatelessWidget {
  TitleTextForm({required this.title, this.textAlign, Key? key}) : super(key: key);

  String title;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: const TextStyle(
        color: CustomColors.grape_juice,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
