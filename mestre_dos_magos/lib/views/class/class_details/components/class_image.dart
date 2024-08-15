import 'package:flutter/material.dart';
import '../../../../models/class.dart';

class ClassImage extends StatelessWidget {
  ClassImage({required this.classe});

  final Class classe;

  @override
  Widget build(BuildContext context) {
    String imagePath;

    switch (classe.name!.toLowerCase()) {
      case 'bárbaro':
        imagePath = 'images/classes/barbarian.png';
        break;
      case 'bardo':
        imagePath = 'images/classes/bard.png';
        break;
      case 'bruxo':
        imagePath = 'images/classes/warlock.png';
        break;
      case 'clérigo':
        imagePath = 'images/classes/cleric.png';
        break;
      case 'druida':
        imagePath = 'images/classes/druid.png';
        break;
      case 'feiticeiro':
        imagePath = 'images/classes/sorcerer.png';
        break;
      case 'guerreiro':
        imagePath = 'images/classes/warrior.png';
        break;
      case 'ladino':
        imagePath = 'images/classes/rogue.png';
        break;
      case 'mago':
        imagePath = 'images/classes/wizard.png';
        break;
      case 'monge':
        imagePath = 'images/classes/monk.png';
        break;
      case 'paladino':
        imagePath = 'images/classes/paladin.png';
        break;
      case 'patrulheiro':
        imagePath = 'images/classes/ranger.png';
        break;
      default:
        imagePath = 'images/classes/default.png';
        break;
    }

    return Positioned.fill(
      child: Image.asset(
        imagePath,
        height: 400,
      ),
    );
  }
}
