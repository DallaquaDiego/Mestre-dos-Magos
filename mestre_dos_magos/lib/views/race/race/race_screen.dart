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
import '../../../stores/list/race_store.dart';

import '../create_race/create_race_screen.dart';
import 'components/filter_visible_race.dart';
import 'components/race_tile.dart';


class RaceScreen extends StatelessWidget {
  RaceScreen({super.key});

  final raceStore = GetIt.I<RaceStore>();
  final filterStore = GetIt.I<FilterSearchStore>();

  @override
  Widget build(BuildContext context) {
    final smallerThanTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.white_mist,
        iconTheme: const IconThemeData(color: CustomColors.dragon_blood),
        title: const Center(
          child: Text(
            'Raças',
            style: TextStyle(
              color: CustomColors.dragon_blood,
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
      backgroundColor: CustomColors.white_mist,
      drawer: smallerThanTablet ? CustomDrawer() : null,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Cadastrar Nova Raça",
        label: const Text("Nova Raça"),
        heroTag: 'Nova Raça',
        backgroundColor: CustomColors.ancient_gold,
        foregroundColor: CustomColors.white_mist,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateRaceScreen(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      body: RefreshIndicator(
        color: CustomColors.dragon_blood,
        onRefresh: () async {
          await raceStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (raceStore.error != null) {
              return ErrorListing(
                text: raceStore.error!,
                reload: raceStore.refreshData,
              );
            }

            if (raceStore.showProgress) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.dragon_blood,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  if (filterStore.visibleSearch) ...{FilterVisibleRace(filterStore: raceStore.filterStore)},
                  if (raceStore.listRace.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhuma Raça Encontrada!',
                          reload: raceStore.refreshData,
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
                          if (index < raceStore.listRace.length) {
                            final race = raceStore.listRace[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                RaceTile(race: race),
                                if (index == raceStore.listRace.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          raceStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.dragon_blood,
                              backgroundColor: CustomColors.dragon_blood.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: raceStore.itemCount,
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
