import 'package:mestre_dos_magos/views/class/create_class/create_class_screen.dart';
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
import '../../../stores/filter_search_store.dart';
import '../../../stores/item_store.dart';
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
        title: const Text(
          'Itens',
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
        tooltip: "Cadastrar Novo Item",
        label: const Text("Novo Item"),
        heroTag: 'Novo Item',
        backgroundColor: CustomColors.coconut,
        foregroundColor: CustomColors.alabaster,
        onPressed: () {
          /*Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateClassScreen(),
            ),
          );*/
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      body: RefreshIndicator(
        color: CustomColors.coconut,
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
                  color: CustomColors.coconut,
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
                            return index == 0 ? Column (
                              children: [
                                const ListDivider(),
                                ItemTile(item: item),
                                const ListDivider(),
                              ],
                            ) : Column (
                              children: [
                                ItemTile(item: item),
                                const ListDivider(),
                              ],
                            );
                          }
                          itemStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.coconut,
                              backgroundColor: CustomColors.coconut.withAlpha(100),
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
