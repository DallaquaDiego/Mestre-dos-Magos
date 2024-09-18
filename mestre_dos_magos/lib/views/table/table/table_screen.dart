import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../core/ui/components/custom_drawer/custom_drawer.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../core/ui/components/dialogs/dialog_monsters.dart';
import '../../../core/ui/components/dialogs/dialog_players.dart';
import '../../../models/monster.dart';
import '../../../models/player.dart';
import '../../../stores/list/monster_store.dart';
import '../../../stores/list/player_store.dart';
import 'components/player_container.dart';
import 'components/monster_container.dart';

class TableScreen extends StatefulWidget {
  TableScreen({super.key});

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final playerStore = GetIt.I<PlayerStore>();
  final monsterStore = GetIt.I<MonsterStore>();

  List<Player> selectedPlayers = [];
  List<Monster> selectedMonsters = [];

  void removeMonster(Monster monster) {
    setState(() {
      selectedMonsters.remove(monster);
    });
  }

  void removePlayer(Player player) {
    setState(() {
      selectedPlayers.remove(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    final smallerThanTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.white_mist,
        iconTheme: const IconThemeData(color: CustomColors.dragon_blood),
        title: const Text(
          'Mesa',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CustomColors.dragon_blood,
          ),
        ),
      ),
      backgroundColor: CustomColors.white_mist,
      drawer: smallerThanTablet ? CustomDrawer() : null,
      body: RefreshIndicator(
        color: CustomColors.dragon_blood,
        onRefresh: () async {
          await playerStore.refreshData();
        },
        child: Observer(
          builder: (context) {
            if (playerStore.showProgress) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.dragon_blood,
                ),
              );
            }

            final firstRowPlayers = selectedPlayers.length <= 2
                ? selectedPlayers
                : selectedPlayers.sublist(0, 2);
            final thirdRowPlayers = selectedPlayers.length > 2
                ? selectedPlayers.sublist(2)
                : [];

            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double containerHeight = constraints.maxHeight / 3 - 16;

                  return Column(
                    children: [
                      if (firstRowPlayers.isNotEmpty)
                        Row(
                          children: [
                            for (var player in firstRowPlayers)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    height: containerHeight,
                                    child: PlayerContainer(
                                      player: player,
                                      onRemove: () => removePlayer(player),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(height: 16),
                      if (selectedMonsters.isNotEmpty)
                        Row(
                          children: [
                            for (var monster in selectedMonsters)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    height: containerHeight,
                                    child: MonsterContainer(
                                      monster: monster,
                                      onRemove: () => removeMonster(monster),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(height: 16),
                      if (thirdRowPlayers.isNotEmpty)
                        Row(
                          children: [
                            for (var player in thirdRowPlayers)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    height: containerHeight,
                                    child: PlayerContainer(
                                      player: player,
                                      onRemove: () => removePlayer(player),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => MonstersDialog(),
              );
              if (result != null) {
                setState(() {
                  selectedMonsters.addAll(result);
                });
              }
            },
            backgroundColor: CustomColors.dragon_blood,
            child: const Icon(Icons.adb),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => PlayersDialog(),
              );
              if (result != null) {
                setState(() {
                  selectedPlayers.addAll(result);
                });
              }
            },
            backgroundColor: CustomColors.dragon_blood,
            child: const Icon(Icons.person_search),
          ),
        ],
      ),
    );
  }
}
