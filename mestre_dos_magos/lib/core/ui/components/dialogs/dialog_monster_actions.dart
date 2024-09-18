import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../../../../models/monster_action.dart';
import '../../../../stores/list/monster_action_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../empty_result.dart';


class DialogMonsterActions extends StatelessWidget {
  DialogMonsterActions({Key? key, List<MonsterAction>? selectedActions})
      : _selectedMonsterActions = ObservableList<MonsterAction>.of(selectedActions ?? []),
        super(key: key);

  final monsterActionStore = GetIt.I<MonsterActionStore>();
  final ObservableList<MonsterAction> _selectedMonsterActions;
  final divider = const Divider(height: 0);

  void _toggleSelectedMonsterAction(MonsterAction newAction) {
    bool isAlreadySelected = _selectedMonsterActions.any((action) => action.id == newAction.id);
    if (isAlreadySelected) {
      _selectedMonsterActions.removeWhere((action) => action.id == newAction.id);
    } else {
      _selectedMonsterActions.add(newAction);
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
                        'Selecione as Ações do Monstro',
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
                          color: CustomColors.dragon_blood,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onChanged: (value) => monsterActionStore.runFilter(value),
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
                },
              ),
              Observer(
                builder: (context) {
                  if (monsterActionStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.dragon_blood,
                        ),
                      ),
                    );
                  }
                  if (monsterActionStore.listMonsterAction.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhuma Ação Encontrada!',
                          reload: monsterActionStore.refreshData,
                        ),
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
                              if (index < monsterActionStore.listSearch.length) {
                                final action = monsterActionStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedMonsterAction(action);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedMonsterActions.any((selectedAction) => selectedAction.id == action.id)
                                            ? CustomColors.dragon_blood.withAlpha(50)
                                            : null,
                                        border: monsterActionStore.listSearch.length - 1 == index
                                            ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        )
                                            : null,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                        child: Text(
                                          '${action.name!.toUpperCase()}\n${action.description}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: CustomColors.dirty_brown,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              monsterActionStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.dragon_blood,
                                  backgroundColor: CustomColors.dragon_blood.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: monsterActionStore.listSearch.length,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.dragon_blood,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(_selectedMonsterActions);
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                color: CustomColors.white_mist,
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
