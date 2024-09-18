import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/stores/list/combat_type_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../models/combat_type.dart';
import '../../theme/custom_colors.dart';
import '../empty_result.dart';

class DialogCombatType extends StatelessWidget {
  DialogCombatType({Key? key, this.selectedCombatType}) : super(key: key);

  final combatTypeStore = GetIt.I<CombatTypeStore>();
  final CombatType? selectedCombatType;

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
                    'Selecione o Tipo de Combate',
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
                    onChanged: (value) => combatTypeStore.runFilter(value),
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
              if (combatTypeStore.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.dragon_blood,
                    ),
                  ),
                );
              }

              if (combatTypeStore.listCombatType.isEmpty) {
                return Expanded(
                  child: Center(
                    child: EmptyResult(
                      text: 'Nenhum Tipo de Combate Encontrado!',
                      reload: combatTypeStore.refreshData,
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final combatType = combatTypeStore.listSearch[index];

                    return InkWell(
                      onTap: () => Navigator.of(context).pop(combatType),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: combatType.id == selectedCombatType?.id ? CustomColors.dragon_blood.withAlpha(50) : null,
                          border: combatTypeStore.listCombatType.length - 1 == index ? Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ) : null,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          combatType.name!,
                          style: const TextStyle(
                            color: CustomColors.dirty_brown,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => divider,
                  itemCount: combatTypeStore.listSearch.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
