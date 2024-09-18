import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/models/player.dart';
import 'package:mestre_dos_magos/views/player/player_details/player_details_screen.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'player_damage_dialog.dart';

class PlayerContainer extends StatefulWidget {
  const PlayerContainer({
    Key? key,
    required this.player,
    this.onRemove,
  }) : super(key: key);

  final Player player;
  final VoidCallback? onRemove;

  @override
  _PlayerContainerState createState() => _PlayerContainerState();
}

class _PlayerContainerState extends State<PlayerContainer> {
  late Player _player;

  @override
  void initState() {
    super.initState();
    _player = widget.player;
  }

  void _updatePlayer() {
    setState(() {
      _player = _player;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlayerDetailsScreen(player: _player),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColors.ancient_gold,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CustomColors.dirty_brown.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -6,
              right: -6,
              child: IconButton(
                icon: const Icon(Icons.close, color: CustomColors.white_mist),
                onPressed: widget.onRemove,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Text(
                  _player.name!,
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HP: ${_player.current_hp}',
                      style: const TextStyle(
                        color: CustomColors.white_mist,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 9),
                    Text(
                      'CA: ${_player.ca}',
                      style: const TextStyle(
                        color: CustomColors.white_mist,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Classe: ${_player.classe!.name!}',
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                Text(
                  _player.sub_race != null
                      ? 'Sub-Raça: ${_player.sub_race!.name}'
                      : 'Raça: ${_player.race!.name}',
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PlayerDamageDialog(
                            heal: false,
                            player: _player,
                            onUpdate: _updatePlayer,
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.dragon_blood,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Dano',
                      style: TextStyle(
                        color: CustomColors.white_mist,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PlayerDamageDialog(
                            heal: true,
                            player: _player,
                            onUpdate: _updatePlayer,
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.white_mist,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Cura',
                      style: TextStyle(
                        color: CustomColors.ancient_gold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
