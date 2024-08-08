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
import '../../../stores/list/racial_trait_store.dart';
import '../create_racial_trait/create_racial_trait_screen.dart';
import 'components/filter_visible_racial_trait.dart';
import 'components/racial_trait_tile.dart';


class RacialTraitScreen extends StatelessWidget {
  RacialTraitScreen({super.key});

  final racialTraitStore = GetIt.I<RacialTraitStore>();
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
            'Traços Raciais',
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
        tooltip: "Cadastrar Novo Traço Racial",
        label: const Text("Novo Traço Racial"),
        heroTag: 'Novo Traço Racial',
        backgroundColor: CustomColors.grape_juice,
        foregroundColor: CustomColors.alabaster,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateRacialTraitScreen(),
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
          await racialTraitStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (racialTraitStore.error != null) {
              return ErrorListing(
                text: racialTraitStore.error!,
                reload: racialTraitStore.refreshData,
              );
            }

            if (racialTraitStore.showProgress) {
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
                  if (filterStore.visibleSearch) ...{FilterVisibleRacialTrait(filterStore: racialTraitStore.filterStore)},
                  if (racialTraitStore.listRacialTrait.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhum Traço Racial Encontrado!',
                          reload: racialTraitStore.refreshData,
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
                          if (index < racialTraitStore.listRacialTrait.length) {
                            final racialTrait = racialTraitStore.listRacialTrait[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                RacialTraitTile(racialTrait: racialTrait),
                                if (index == racialTraitStore.listRacialTrait.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          racialTraitStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.grape_juice,
                              backgroundColor: CustomColors.grape_juice.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: racialTraitStore.itemCount,
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
