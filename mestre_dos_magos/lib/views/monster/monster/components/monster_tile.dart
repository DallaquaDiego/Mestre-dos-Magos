import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/views/monster/create_monster/create_monster_screen.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../../models/monster.dart';
import '../../monster_details/monster_details_screen.dart';

class MonsterTile extends StatelessWidget {
  const MonsterTile({Key? key, required this.monster}) : super(key: key);

  final Monster monster;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(vertical: 8),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MonsterDetailsScreen(monster: monster),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                monster.name!,
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Nível de Desafio: ${monster.challenge_level!}',
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                'HP: ${monster.hp!}',
                style: const TextStyle(
                  color: CustomColors.amethyst,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateMonsterScreen(monster: monster),
              )
            );
          },
          icon: const Icon(
            Icons.edit,
            color: CustomColors.amethyst,
          ),
        ),
      ),
    );
  }
}
