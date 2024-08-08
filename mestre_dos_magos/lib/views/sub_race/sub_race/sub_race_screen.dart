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

import '../../../stores/list/sub_race_store.dart';
import '../create_sub_race/create_sub_race_screen.dart';
import 'components/filter_visible_sub_race.dart';
import 'components/sub_race_tile.dart';


class SubRaceScreen extends StatelessWidget {
  SubRaceScreen({super.key});

  final subRaceStore = GetIt.I<SubRaceStore>();
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
            'Sub-Raças',
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
        tooltip: "Cadastrar Nova Sub-Raça",
        label: const Text("Nova Sub-Raça"),
        heroTag: 'Nova Sub-Raça',
        backgroundColor: CustomColors.grape_juice,
        foregroundColor: CustomColors.alabaster,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateSubRaceScreen(),
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
          await subRaceStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (subRaceStore.error != null) {
              return ErrorListing(
                text: subRaceStore.error!,
                reload: subRaceStore.refreshData,
              );
            }

            if (subRaceStore.showProgress) {
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
                  if (filterStore.visibleSearch) ...{FilterVisibleSubRace(filterStore: subRaceStore.filterStore)},
                  if (subRaceStore.listSubRace.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhuma Sub-Raça Encontrada!',
                          reload: subRaceStore.refreshData,
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
                          if (index < subRaceStore.listSubRace.length) {
                            final subRace = subRaceStore.listSubRace[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                SubRaceTile(subRace: subRace),
                                if (index == subRaceStore.listSubRace.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          subRaceStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.grape_juice,
                              backgroundColor: CustomColors.grape_juice.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: subRaceStore.itemCount,
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
