import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/models/monster_skill.dart';
import 'package:mobx/mobx.dart';

import '../../../../stores/list/monster_skill_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../list_empty.dart';


class DialogMonsterSkills extends StatelessWidget {
  DialogMonsterSkills({Key? key, List<MonsterSkill>? selectedSkills})
      : _selectedMonsterSkills = ObservableList<MonsterSkill>.of(selectedSkills ?? []),
        super(key: key);

  final monsterSkillStore = GetIt.I<MonsterSkillStore>();
  final ObservableList<MonsterSkill> _selectedMonsterSkills;
  final divider = const Divider(height: 0);

  void _toggleSelectedMonsterSkill(MonsterSkill newSkill) {
    bool isAlreadySelected = _selectedMonsterSkills.any((skill) => skill.id == newSkill.id);
    if (isAlreadySelected) {
      _selectedMonsterSkills.removeWhere((skill) => skill.id == newSkill.id);
    } else {
      _selectedMonsterSkills.add(newSkill);
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
                        'Selecione as Habilidades do Monstro',
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
                          onChanged: (value) => monsterSkillStore.runFilter(value),
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
                  if (monsterSkillStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    );
                  }
                  if (monsterSkillStore.listMonsterSkill.isEmpty) {
                    return const Expanded(
                      child: ListEmpty(
                        texto: "Nenhuma Habilidade Encontrada!",
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
                              if (index < monsterSkillStore.listMonsterSkill.length) {
                                final skill = monsterSkillStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedMonsterSkill(skill);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedMonsterSkills.any((selectedSkill) => selectedSkill.id == skill.id) ? CustomColors.grape_juice.withAlpha(50) : null,
                                        border: monsterSkillStore.listMonsterSkill.length - 1 == index ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                          ),
                                        ) : null,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                        child: Text(
                                          '${skill.name!.toUpperCase()}\n${skill.description}',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ),
                                  ),
                                );
                              }
                              monsterSkillStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.grape_juice,
                                  backgroundColor: CustomColors.grape_juice.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: monsterSkillStore.listSearch.length,
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
                              Navigator.of(context).pop(_selectedMonsterSkills);
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
