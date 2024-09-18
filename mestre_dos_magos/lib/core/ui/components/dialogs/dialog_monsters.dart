import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/monster.dart';
import '../../../../stores/list/monster_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../empty_result.dart';

class MonstersDialog extends StatelessWidget {
  MonstersDialog({Key? key, List<Monster>? selectedMonsters})
      : _selectedMonsters = ObservableList<Monster>.of(selectedMonsters ?? []),
        super(key: key);

  final monsterStore = GetIt.I<MonsterStore>();
  final ObservableList<Monster> _selectedMonsters;
  final divider = const Divider(height: 0);

  void _toggleSelectedMonster(BuildContext context, Monster newMonster) {
    bool isAlreadySelected = _selectedMonsters.any((monster) => monster.id == newMonster.id);
    if (isAlreadySelected) {
      _selectedMonsters.removeWhere((monster) => monster.id == newMonster.id);
    } else {
      if (_selectedMonsters.length <= 2) {
        _selectedMonsters.add(newMonster);
      }
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
                        'Selecione no Máximo 2 Monstros',
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
                          onChanged: (value) => monsterStore.runFilter(value),
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
                  if (monsterStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.dragon_blood,
                        ),
                      ),
                    );
                  }
                  if (monsterStore.listMonster.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: EmptyResult(
                          text: 'Nenhum Monstro Encontrado!',
                          reload: monsterStore.refreshData,
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
                              if (index < monsterStore.listSearch.length) {
                                final monster = monsterStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedMonster(context, monster);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedMonsters.any((selectedMonster) => selectedMonster.id == monster.id)
                                            ? CustomColors.dragon_blood.withAlpha(50)
                                            : null,
                                        border: monsterStore.listMonster.length - 1 == index
                                            ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        )
                                            : null,
                                      ),
                                      child: Text(
                                        monster.name!,
                                        style: const TextStyle(
                                          color: CustomColors.dirty_brown,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              monsterStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.dragon_blood,
                                  backgroundColor: CustomColors.dragon_blood.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: monsterStore.itemCount,
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
                              Navigator.of(context).pop(_selectedMonsters);
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
