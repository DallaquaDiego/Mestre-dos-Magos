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
        title: const Text(
          'Raças',
          style: TextStyle(
            color: CustomColors.alabaster,
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
        backgroundColor: CustomColors.coconut,
        iconTheme: const IconThemeData(
          color: CustomColors.alabaster, // Altere esta cor conforme necessário
        ),
      ),
      backgroundColor: CustomColors.papyrus,
      drawer: smallerThanTablet ? CustomDrawer() : null,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Cadastrar Nova Raça",
        label: const Text("Nova Raça"),
        heroTag: 'Nova Raça',
        backgroundColor: CustomColors.coconut,
        foregroundColor: CustomColors.alabaster,
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
        color: CustomColors.coconut,
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
                  color: CustomColors.coconut,
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
                            return index == 0 ? Column (
                              children: [
                                const ListDivider(),
                                RaceTile(race: race),
                                const ListDivider(),
                              ],
                            ) : Column (
                              children: [
                                RaceTile(race: race),
                                const ListDivider(),
                              ],
                            );
                          }
                          raceStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.coconut,
                              backgroundColor: CustomColors.coconut.withAlpha(100),
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
