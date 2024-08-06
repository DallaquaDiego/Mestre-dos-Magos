import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade400,
            blurRadius: 9, // Desfoque da sombra
            offset: const Offset(0, 3), // Deslocamento da sombra (horizontal, vertical)
          ),
        ],
        border: const Border(
          top: BorderSide(color: Colors.brown, width: 2),
          bottom: BorderSide(color: Colors.brown, width: 2),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
