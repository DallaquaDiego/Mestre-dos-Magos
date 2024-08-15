import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../../core/ui/components/custom_drawer/custom_drawer.dart';
import '../../../../core/ui/components/error_listing.dart';
import '../../../../core/ui/components/list_divider.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../core/ui/components/empty_result.dart';
import '../../../core/ui/components/flutter_icon_with_badge.dart';
import '../../../../stores/filter_search_store.dart';
import '../../../stores/list/monster_store.dart';
import '../create_monster/create_monster_screen.dart';
import 'components/filter_visible_monster.dart';
import 'components/monster_tile.dart';


class MonsterScreen extends StatelessWidget {
  MonsterScreen({super.key});

  final monsterStore = GetIt.I<MonsterStore>();
  final filterStore = GetIt.I<FilterSearchStore>();

  @override
  Widget build(BuildContext context) {
    final smallerThanTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.mystical_lilac,
        iconTheme: const IconThemeData(color: CustomColors.grape_juice),
        title: const Center(
          child: Text(
            'Monstros',
            style: TextStyle(
              color: CustomColors.grape_juice,
            ),
          ),
        ),
        actions: [
          Observer(
            builder: (_) {
              return FilterIconWithBadge(
                ontap: () {
                  filterStore.setVisibleSearch();
                },
                number: filterStore.getCountFilter,
              );
            },
          ),
        ],
      ),
      backgroundColor: CustomColors.mystical_lilac,
      drawer: smallerThanTablet ? CustomDrawer() : null,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Cadastrar Novo Monstro",
        label: const Text("Novo Monstro"),
        heroTag: 'Novo Monstro',
        backgroundColor: CustomColors.grape_juice,
        foregroundColor: CustomColors.alabaster,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateMonsterScreen(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      body: RefreshIndicator(
        color: CustomColors.grape_juice,
        onRefresh: () async {
          await monsterStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (monsterStore.error != null) {
              return ErrorListing(
                text: monsterStore.error!,
                reload: monsterStore.refreshData,
              );
            }

            if (monsterStore.showProgress) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.grape_juice,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  if (filterStore.visibleSearch) ...{FilterVisibleMonster(filterStore: monsterStore.filterStore)},
                  if (monsterStore.listMonster.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhum Monstro Encontrado!',
                          reload: monsterStore.refreshData,
                        ),
                      ),
                    ),
                  } else ...{
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < monsterStore.listMonster.length) {
                            final monster = monsterStore.listMonster[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                MonsterTile(monster: monster),
                                if (index == monsterStore.listMonster.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          monsterStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.grape_juice,
                              backgroundColor: CustomColors.grape_juice.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: monsterStore.itemCount,
                      ),
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
