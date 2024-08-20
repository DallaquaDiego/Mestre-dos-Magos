import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/models/player.dart';
import 'package:mestre_dos_magos/views/player/player_details/player_details_screen.dart';

import '../../../../core/ui/theme/custom_colors.dart';
import 'player_damage_dialog.dart';

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlayerDetailsScreen(player: player),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColors.alabaster,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CustomColors.midnight.withOpacity(0.1),
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
                  player.name!,
                  style: const TextStyle(
                    color: CustomColors.grape_juice,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                Text(
                  'CA: ${player.ca}',
                  style: const TextStyle(
                    color: CustomColors.amethyst,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                Text(
                  'HP: ${player.current_hp}',
                  style: const TextStyle(
                    color: CustomColors.amethyst,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                Text(
                  'Classe: ${player.classe!.name!}',
                  style: const TextStyle(
                    color: CustomColors.amethyst,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                Text(
                  player.sub_race != null
                      ? 'Sub-Raça: ${player.sub_race!.name}'
                      : 'Raça: ${player.race!.name}',
                  style: const TextStyle(
                    color: CustomColors.amethyst,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PlayerDamageDialog(
                          heal: false,
                          player: player,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.grape_juice,
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
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PlayerDamageDialog(
                          heal: true,
                          player: player,
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
