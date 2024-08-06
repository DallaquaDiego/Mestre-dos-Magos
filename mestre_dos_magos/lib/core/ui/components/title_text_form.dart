import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';

class TitleTextForm extends StatelessWidget {
  TitleTextForm({required this.title, Key? key}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: CustomColors.coconut,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
