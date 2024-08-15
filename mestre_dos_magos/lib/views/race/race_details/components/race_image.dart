import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/models/race.dart';

class RaceImage extends StatelessWidget {
  RaceImage({required this.race});

  final Race race;

  @override
  Widget build(BuildContext context) {
    String imagePath;

    switch (race.name!.toLowerCase()) {
      case 'anão':
        imagePath = 'images/races/dwarf.png';
        break;
      case 'elfo':
        imagePath = 'images/races/elf.png';
        break;
      case 'halfling':
        imagePath = 'images/races/halfling.png';
        break;
      case 'humano':
        imagePath = 'images/races/human.png';
        break;
      case 'draconato':
        imagePath = 'images/races/dragonborn.png';
        break;
      case 'gnomo':
        imagePath = 'images/races/gnome.png';
        break;
      case 'meio-elfo':
        imagePath = 'images/races/half_elf.png';
        break;
      case 'meio-orc':
        imagePath = 'images/races/half_orc.png';
        break;
      case 'tiefling':
        imagePath = 'images/races/tiefling.png';
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
