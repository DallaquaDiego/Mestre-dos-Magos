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
import '../../../stores/list/table_store.dart';
import 'components/player_container.dart';
import 'components/monster_container.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final tableStore = GetIt.I<TableStore>();

  List<Player> selectedPlayers = [];
  List<Monster> selectedMonsters = [];

  void addSelectedPlayers(List<Player> players) {
    if (selectedPlayers.length + players.length <= 4) {
      setState(() {
        selectedPlayers.addAll(players);
      });
    }
  }

  void addSelectedMonsters(List<Monster> monsters) {
    if (selectedMonsters.length + monsters.length <= 2) {
      setState(() {
        selectedMonsters.addAll(monsters);
      });
    }
  }

  void removePlayer(Player player) {
    setState(() {
      selectedPlayers.removeWhere((p) => p.id == player.id);
    });
  }

  void removeMonster(Monster monster) {
    setState(() {
      selectedMonsters.removeWhere((m) => m.id == monster.id);
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
          await tableStore.refreshData();
        },
        child: Observer(
          builder: (context) {
            if (tableStore.showProgress) {
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

            final containerHeight = (MediaQuery.of(context).size.height * 0.30) - 16; // 30% of screen height minus padding

            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      if (firstRowPlayers.isNotEmpty)
                        Row(
                          children: [
                            if (firstRowPlayers.length == 1)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    height: containerHeight,
                                    child: PlayerContainer(
                                      key: ValueKey(firstRowPlayers.first.id),
                                      player: firstRowPlayers.first,
                                      onRemove: () => removePlayer(firstRowPlayers.first),
                                    ),
                                  ),
                                ),
                              )
                            else
                              for (var player in firstRowPlayers)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: SizedBox(
                                      height: containerHeight,
                                      child: PlayerContainer(
                                        key: ValueKey(player.id),
                                        player: player,
                                        onRemove: () => removePlayer(player),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      const SizedBox(height: 8),

                      if (selectedMonsters.isNotEmpty)
                        Row(
                          children: [
                            if (selectedMonsters.length == 1)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    height: containerHeight,
                                    child: MonsterContainer(
                                      key: ValueKey(selectedMonsters.first.id),
                                      monster: selectedMonsters.first,
                                      onRemove: () => removeMonster(selectedMonsters.first),
                                    ),
                                  ),
                                ),
                              )
                            else
                              for (var monster in selectedMonsters)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: SizedBox(
                                      height: containerHeight,
                                      child: MonsterContainer(
                                        key: ValueKey(monster.id),
                                        monster: monster,
                                        onRemove: () => removeMonster(monster),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      const SizedBox(height: 8),

                      if (thirdRowPlayers.isNotEmpty)
                        Row(
                          children: [
                            if (thirdRowPlayers.length == 1)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    height: containerHeight,
                                    child: PlayerContainer(
                                      key: ValueKey(thirdRowPlayers.first.id),
                                      player: thirdRowPlayers.first,
                                      onRemove: () => removePlayer(thirdRowPlayers.first),
                                    ),
                                  ),
                                ),
                              )
                            else
                              for (var player in thirdRowPlayers)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: SizedBox(
                                      height: containerHeight,
                                      child: PlayerContainer(
                                        key: ValueKey(player.id),
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
                addSelectedMonsters(result);
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
                addSelectedPlayers(result);
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
