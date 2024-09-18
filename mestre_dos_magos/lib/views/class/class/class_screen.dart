import 'package:mestre_dos_magos/views/class/class/components/filter_visible_class.dart';
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
import '../../../stores/list/class_store.dart';
import '../../../../stores/filter_search_store.dart';
import 'components/class_tile.dart';


class ClassScreen extends StatelessWidget {
  ClassScreen({super.key});

  final classStore = GetIt.I<ClassStore>();
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
            'Classes',
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
        tooltip: "Cadastrar Nova Classe",
        label: const Text("Nova Classe"),
        heroTag: 'Nova Classe',
        backgroundColor: CustomColors.ancient_gold,
        foregroundColor: CustomColors.white_mist,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateClassScreen(),
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
          await classStore.refreshData();
        },
        child: Observer(
          builder: (context) {
            if (classStore.error != null) {
              return ErrorListing(
                text: classStore.error!,
                reload: classStore.refreshData,
              );
            }

            if (classStore.showProgress) {
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
                  if (filterStore.visibleSearch) ...{FilterVisibleClass(filterStore: classStore.filterStore)},
                  if (classStore.listClass.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhuma Classe Encontrado!',
                          reload: classStore.refreshData,
                        ),
                      ),
                    ),
                  } else ...{
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < classStore.listClass.length) {
                            final classe = classStore.listClass[index];
                            return Column(
                              children: [
                                if (index == 0) const ListDivider(),
                                ClassTile(classe: classe),
                                if (index == classStore.listClass.length - 1) const ListDivider(),
                              ],
                            );
                          }
                          classStore.loadNextPage();
                          return Center(
                            child: LinearProgressIndicator(
                              color: CustomColors.dragon_blood,
                              backgroundColor: CustomColors.dragon_blood.withAlpha(100),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => const ListDivider(),
                        itemCount: classStore.itemCount,
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
