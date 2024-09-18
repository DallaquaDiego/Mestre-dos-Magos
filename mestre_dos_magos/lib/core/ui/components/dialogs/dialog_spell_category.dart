import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../models/spell_category.dart';
import '../../../../stores/list/spell_category_store.dart';
import '../../theme/custom_colors.dart';
import '../empty_result.dart';

class DialogSpellCategory extends StatelessWidget {
  DialogSpellCategory({Key? key, this.selectedSpellCategory}) : super(key: key);

  final spellCategoryStore = GetIt.I<SpellCategoryStore>();
  final SpellCategory? selectedSpellCategory;

  final divider = const Divider(height: 0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Selecione a Categoria da Magia',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.dragon_blood,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 25,
                      color: CustomColors.dragon_blood,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
          divider,
          Observer(builder: (_) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                height: 63,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: CustomColors.dragon_blood,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    onChanged: (value) => spellCategoryStore.runFilter(value),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: CustomColors.dragon_blood,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          Observer(
            builder: (context) {
              if (spellCategoryStore.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.dragon_blood,
                    ),
                  ),
                );
              }

              if (spellCategoryStore.listSpellCategory.isEmpty) {
                return Expanded(
                  child: Center(
                    child: EmptyResult(
                      text: 'Nenhuma Categoria Encontrada!',
                      reload: spellCategoryStore.refreshData,
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final spellCategory = spellCategoryStore.listSearch[index];

                    return InkWell(
                      onTap: () => Navigator.of(context).pop(spellCategory),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: spellCategory.id == selectedSpellCategory?.id ? CustomColors.dragon_blood.withAlpha(50) : null,
                          border: spellCategoryStore.listSpellCategory.length - 1 == index
                              ? Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          )
                              : null,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          spellCategory.name!,
                          style: const TextStyle(
                            color: CustomColors.dirty_brown,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => divider,
                  itemCount: spellCategoryStore.listSearch.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
