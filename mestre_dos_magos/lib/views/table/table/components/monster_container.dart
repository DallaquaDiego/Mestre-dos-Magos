import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/models/monster.dart';
import 'package:mestre_dos_magos/views/table/table/components/monster_damage_dialog.dart';
import 'package:mestre_dos_magos/views/table/table/components/player_damage_dialog.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import '../../../monster/monster_details/monster_details_screen.dart';

class MonsterContainer extends StatelessWidget {
  const MonsterContainer({Key? key, required this.monster}) : super(key: key);

  final Monster monster;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MonsterDetailsScreen(monster: monster),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColors.grape_juice,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CustomColors.midnight.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  monster.name!,
                  style: const TextStyle(
                    color: CustomColors.alabaster,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'HP: ${monster.current_hp}',
                  style: const TextStyle(
                    color: CustomColors.mystical_lilac,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Nível: ${monster.challenge_level}',
                  style: const TextStyle(
                    color: CustomColors.mystical_lilac,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'CA: ${monster.ca}',
                  style: const TextStyle(
                    color: CustomColors.mystical_lilac,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Resistências: ${monster.endurance_tests}',
                  style: const TextStyle(
                    color: CustomColors.mystical_lilac,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MonsterDamageDialog(
                          heal: false,
                          monster: monster,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.midnight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Dano',
                    style:TextStyle(
                      color: CustomColors.alabaster
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MonsterDamageDialog(
                          heal: true,
                          monster: monster,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.alabaster,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Cura',
                    style:TextStyle(
                        color: CustomColors.grape_juice
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
