import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';

class ListEmpty extends StatelessWidget {
  const ListEmpty({
    super.key,
    required this.texto,
  });

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: CustomColors.grape_juice,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }
}
