import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/views/item_category/create_item_category/create_item_category_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../../core/ui/components/custom_drawer/custom_drawer.dart';
import '../../../../core/ui/components/error_listing.dart';
import '../../../../core/ui/components/list_divider.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import '../../../core/ui/components/empty_result.dart';
import '../../../core/ui/components/flutter_icon_with_badge.dart';
import '../../../../stores/filter_search_store.dart';
import '../../../stores/list/item_category_store.dart';
import 'components/filter_visible_item_category.dart';
import 'components/item_category_tile.dart';


class ItemCategoryScreen extends StatelessWidget {
  ItemCategoryScreen({super.key});

  final itemCategoryStore = GetIt.I<ItemCategoryStore>();
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
            'Categorias de Itens',
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
        tooltip: "Cadastrar Nova Categoria",
        label: const Text("Nova Categoria"),
        heroTag: 'Nova Categoria',
        backgroundColor: CustomColors.grape_juice,
        foregroundColor: CustomColors.alabaster,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateItemCategoryScreen(),
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
          await itemCategoryStore.refreshData();
        },
        child: Observer(

          builder: (context) {
            if (itemCategoryStore.error != null) {
              return ErrorListing(
                text: itemCategoryStore.error!,
                reload: itemCategoryStore.refreshData,
              );
            }

            if (itemCategoryStore.showProgress) {
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
                  if (filterStore.visibleSearch) ...{FilterVisibleItemCategory(filterStore: itemCategoryStore.filterStore)},
                  if (itemCategoryStore.listItemCategory.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhuma Categoria Encontrada!',
                          reload: itemCategoryStore.refreshData,
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
                          if (index < itemCategoryStore.listItemCategory.length) {
                            final itemCategory = itemCategoryStore.listItemCategory[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                ItemCategoryTile(itemCategory: itemCategory),
                                if (index == itemCategoryStore.listItemCategory.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          itemCategoryStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.grape_juice,
                              backgroundColor: CustomColors.grape_juice.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: itemCategoryStore.itemCount,
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
