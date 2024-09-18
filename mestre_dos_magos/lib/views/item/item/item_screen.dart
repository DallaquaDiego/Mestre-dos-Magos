import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/views/item/create_item/create_item_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../../core/ui/components/custom_drawer/custom_drawer.dart';
import '../../../../core/ui/components/error_listing.dart';
import '../../../../core/ui/components/list_divider.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../core/ui/components/empty_result.dart';
import '../../../core/ui/components/flutter_icon_with_badge.dart';
import '../../../../stores/filter_search_store.dart';
import '../../../stores/list/item_store.dart';
import 'components/filter_visible_item.dart';
import 'components/item_tile.dart';


class ItemScreen extends StatelessWidget {
  ItemScreen({super.key});

  final itemStore = GetIt.I<ItemStore>();
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
            'Itens',
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
        tooltip: "Cadastrar Novo Item",
        label: const Text("Novo Item"),
        heroTag: 'Novo Item',
        backgroundColor: CustomColors.ancient_gold,
        foregroundColor: CustomColors.white_mist,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateItemScreen(),
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
          await itemStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (itemStore.error != null) {
              return ErrorListing(
                text: itemStore.error!,
                reload: itemStore.refreshData,
              );
            }

            if (itemStore.showProgress) {
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
                  if (filterStore.visibleSearch) ...{FilterVisibleItem(filterStore: itemStore.filterStore)},
                  if (itemStore.listItem.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhum Item Encontrado!',
                          reload: itemStore.refreshData,
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
                          if (index < itemStore.listItem.length) {
                            final item = itemStore.listItem[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                ItemTile(item: item),
                                if (index == itemStore.listItem.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          itemStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.dragon_blood,
                              backgroundColor: CustomColors.dragon_blood.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: itemStore.itemCount,
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
