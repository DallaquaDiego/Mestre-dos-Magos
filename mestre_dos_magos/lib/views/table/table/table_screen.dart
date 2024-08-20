import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../core/ui/components/custom_drawer/custom_drawer.dart';
import '../../../../core/ui/components/error_listing.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../stores/list/monster_store.dart';
import '../../../stores/list/player_store.dart';
import 'components/player_container.dart';
import 'components/monster_container.dart';

class TableScreen extends StatelessWidget {
  TableScreen({super.key});

  final playerStore = GetIt.I<PlayerStore>();
  final monsterStore = GetIt.I<MonsterStore>();

  @override
  Widget build(BuildContext context) {
    final smallerThanTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.mystical_lilac,
        iconTheme: const IconThemeData(color: CustomColors.grape_juice),
        title: const Text(
          'Mesa',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CustomColors.grape_juice,
          ),
        ),
      ),
      backgroundColor: CustomColors.mystical_lilac,
      drawer: smallerThanTablet ? CustomDrawer() : null,
      body: RefreshIndicator(
        color: CustomColors.grape_juice,
        onRefresh: () async {
          await playerStore.refreshData();
        },
        child: Observer(
          builder: (context) {
            if (playerStore.error != null) {
              return ErrorListing(
                text: playerStore.error!,
                reload: playerStore.refreshData,
              );
            }

            if (playerStore.showProgress) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.grape_juice,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final players = playerStore.listPlayer;
                  final monsters = monsterStore.listMonster;

                  final double containerHeight = constraints.maxHeight / 3 - 16;

                  return Column(
                    children: [
                      Row(
                        children: players.take(2).map((player) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: containerHeight,
                                child: PlayerContainer(player: player),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          ...monsters.map((monster) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  height: containerHeight,
                                  child: MonsterContainer(monster: monster),
                                ),
                              ),
                            );
                          }).toList(),
                          // Verifica se há 5 jogadores e adiciona o quinto jogador nesta linha
                          if (players.length == 5)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  height: containerHeight,
                                  child: PlayerContainer(player: players[4]),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: players.skip(2).take(2).map((player) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: containerHeight,
                                child: PlayerContainer(player: player),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
