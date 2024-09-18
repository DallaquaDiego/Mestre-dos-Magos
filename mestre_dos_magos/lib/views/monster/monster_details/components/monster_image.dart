import 'package:flutter/material.dart';
import '../../../../models/monster.dart';

class MonsterImage extends StatelessWidget {
  MonsterImage({required this.monster});

  final Monster monster;

  @override
  Widget build(BuildContext context) {
    String? imagePath;

    switch (monster.name!.toLowerCase()) {
      case 'dragão azul ancião':
        imagePath = 'images/monsters/ancient_blue_dragon.png';
        break;
      case 'dragão negro ancião':
        imagePath = 'images/monsters/ancient_black_dragon.png';
        break;
      default:
        imagePath = null;
        break;
    }

    if (imagePath == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Image.asset(
        imagePath,
        height: 400,
      ),
    );
  }
}
