import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/monster_legendary_action.dart';
import '../../../../stores/list/monster_legendary_action_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../list_empty.dart';


class DialogMonsterLegendaryActions extends StatelessWidget {
  DialogMonsterLegendaryActions({Key? key, List<MonsterLegendaryAction>? selectedActions})
      : _selectedMonsterLegendaryActions = ObservableList<MonsterLegendaryAction>.of(selectedActions ?? []),
        super(key: key);

  final monsterLegendaryActionStore = GetIt.I<MonsterLegendaryActionStore>();
  final ObservableList<MonsterLegendaryAction> _selectedMonsterLegendaryActions;
  final divider = const Divider(height: 0);

  void _toggleSelectedMonsterLegendaryAction(MonsterLegendaryAction newAction) {
    bool isAlreadySelected = _selectedMonsterLegendaryActions.any((action) => action.id == newAction.id);
    if (isAlreadySelected) {
      _selectedMonsterLegendaryActions.removeWhere((action) => action.id == newAction.id);
    } else {
      _selectedMonsterLegendaryActions.add(newAction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: CustomSizes.maxScreenWidth,
        ),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Selecione as Ações Lendárias do Monstro',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: CustomColors.grape_juice,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
              divider,
              Observer(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Container(
                      height: 63,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: CustomColors.grape_juice,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onChanged: (value) => monsterLegendaryActionStore.runFilter(value),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: CustomColors.grape_juice,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  if (monsterLegendaryActionStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    );
                  }
                  if (monsterLegendaryActionStore.listMonsterLegendaryAction.isEmpty) {
                    return const Expanded(
                      child: ListEmpty(
                        texto: "Nenhuma Ação Lendária Encontrada!",
                      ),
                    );
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < monsterLegendaryActionStore.listMonsterLegendaryAction.length) {
                                final action = monsterLegendaryActionStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedMonsterLegendaryAction(action);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedMonsterLegendaryActions.any((selectedAction) => selectedAction.id == action.id) ? CustomColors.grape_juice.withAlpha(50) : null,
                                        border: monsterLegendaryActionStore.listMonsterLegendaryAction.length - 1 == index ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        ) : null,
                                      ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                          child: Text(
                                            '${action.name!.toUpperCase()}\n${action.description}',
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                    ),
                                  ),
                                );
                              }
                              monsterLegendaryActionStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.grape_juice,
                                  backgroundColor: CustomColors.grape_juice.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: monsterLegendaryActionStore.listSearch.length,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.grape_juice,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(_selectedMonsterLegendaryActions);
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                  color: CustomColors.alabaster
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
