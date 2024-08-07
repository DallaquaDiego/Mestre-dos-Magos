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
import '../../../stores/list/spell_store.dart';
import '../create_spell/create_spell_screen.dart';
import 'components/filter_visible_spell.dart';
import 'components/spell_tile.dart';


class SpellScreen extends StatelessWidget {
  SpellScreen({super.key});

  final spellStore = GetIt.I<SpellStore>();
  final filterStore = GetIt.I<FilterSearchStore>();

  @override
  Widget build(BuildContext context) {
    final smallerThanTablet = ResponsiveWrapper.of(context).isSmallerThan(TABLET);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Truques e Magias',
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
        tooltip: "Cadastrar Nova Magia",
        label: const Text("Nova Magia"),
        heroTag: 'Nova Magia',
        backgroundColor: CustomColors.coconut,
        foregroundColor: CustomColors.alabaster,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateSpellScreen(),
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
          await spellStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (spellStore.error != null) {
              return ErrorListing(
                text: spellStore.error!,
                reload: spellStore.refreshData,
              );
            }

            if (spellStore.showProgress) {
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
                  if (filterStore.visibleSearch) ...{FilterVisibleSpell(filterStore: spellStore.filterStore)},
                  if (spellStore.listSpell.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhuma Magia Encontrada!',
                          reload: spellStore.refreshData,
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
                          if (index < spellStore.listSpell.length) {
                            final spell = spellStore.listSpell[index];
                            return index == 0 ? Column (
                              children: [
                                const ListDivider(),
                                SpellTile(spell: spell),
                                const ListDivider(),
                              ],
                            ) : Column (
                              children: [
                                SpellTile(spell: spell),
                                const ListDivider(),
                              ],
                            );
                          }
                          spellStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.coconut,
                              backgroundColor: CustomColors.coconut.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: spellStore.itemCount,
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
