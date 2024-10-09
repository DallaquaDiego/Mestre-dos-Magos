import 'package:flutter/material.dart';
import 'package:mestre_dos_magos/models/monster.dart';
import 'package:mestre_dos_magos/views/monster/monster_details/monster_details_screen.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'monster_damage_dialog.dart';

class MonsterContainer extends StatefulWidget {
  const MonsterContainer({
    Key? key,
    required this.monster,
    this.onRemove,
  }) : super(key: key);

  final Monster monster;
  final VoidCallback? onRemove;

  @override
  _MonsterContainerState createState() => _MonsterContainerState();
}

class _MonsterContainerState extends State<MonsterContainer> {
  late Monster _monster;

  @override
  void initState() {
    super.initState();
    _monster = widget.monster;
  }

  void _updateMonster() {
    setState(() {
      _monster = _monster;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MonsterDetailsScreen(monster: _monster),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColors.dragon_blood,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CustomColors.dirty_brown.withOpacity(0.2),
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
                const SizedBox(height: 12),
                Text(
                  _monster.name!,
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'HP: ${_monster.current_hp}',
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Nível: ${_monster.challenge_level}',
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'CA: ${_monster.ca}',
                  style: const TextStyle(
                    color: CustomColors.white_mist,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Positioned(
                  bottom: 8,
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
                              return MonsterDamageDialog(
                                heal: false,
                                monster: _monster,
                                onUpdate: _updateMonster,
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
                          'Dano',
                          style: TextStyle(color: CustomColors.dragon_blood),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MonsterDamageDialog(
                                heal: true,
                                monster: _monster,
                                onUpdate: _updateMonster,
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.ancient_gold,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Cura',
                          style: TextStyle(color: CustomColors.white_mist),
                        ),
                      ),
                    ],
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
