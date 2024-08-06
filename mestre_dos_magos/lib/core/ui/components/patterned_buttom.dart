import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';

class PatternedButton extends StatelessWidget {
  const PatternedButton({
    super.key,
    required this.largura,
    required this.color,
    required this.text,
    required this.function,
  });

  final double? largura;
  final Color color;
  final String text;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: largura,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, color: CustomColors.alabaster),
        ),
      ),
    );
  }
}
