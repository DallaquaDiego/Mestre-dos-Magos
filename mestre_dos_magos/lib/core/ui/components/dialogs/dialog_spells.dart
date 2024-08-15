import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';


import '../../../../models/spell.dart';
import '../../../../stores/list/spell_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../list_empty.dart';


class DialogSpells extends StatelessWidget {
  DialogSpells({Key? key, List<Spell>? selectedSpells})
      : _selectedSpells = ObservableList<Spell>.of(selectedSpells ?? []),
        super(key: key);

  final spellStore = GetIt.I<SpellStore>();
  final ObservableList<Spell> _selectedSpells;
  final divider = const Divider(height: 0);

  void _toggleSelectedRacialTrait(Spell newSpell) {
    bool isAlreadySelected = _selectedSpells.any((spell) => spell.id == newSpell.id);
    if (isAlreadySelected) {
      _selectedSpells.removeWhere((spell) => spell.id == newSpell.id);
    } else {
      _selectedSpells.add(newSpell);
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
                        'Selecione os Truques e Magias',
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
                          onChanged: (value) => spellStore.runFilter(value),
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
                  if (spellStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    );
                  }
                  if (spellStore.listSpell.isEmpty) {
                    return const Expanded(
                      child: ListEmpty(
                        texto: "Nenhuma Magia Encontrada!",
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
                              if (index < spellStore.listSearch.length) {
                                final spell = spellStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedRacialTrait(spell);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedSpells.any((selectedSpell) => selectedSpell.id == spell.id)
                                            ? CustomColors.grape_juice.withAlpha(50)
                                            : null,
                                        border: spellStore.listSearch.length - 1 == index
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
                                          spell.name!,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // Carregar próxima página ao chegar no final da lista
                              spellStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.grape_juice,
                                  backgroundColor: CustomColors.grape_juice.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: spellStore.listSearch.length,
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
                              Navigator.of(context).pop(_selectedSpells);
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                color: CustomColors.alabaster,
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
