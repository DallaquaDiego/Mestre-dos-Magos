import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/racial_trait.dart';
import '../../../../stores/list/racial_trait_store.dart';
import '../../../global/custom_sizes.dart';
import '../../theme/custom_colors.dart';
import '../list_empty.dart';


class DialogRacialTraits extends StatelessWidget {
  DialogRacialTraits({Key? key, List<RacialTrait>? selectedRacialTraits})
      : _selectedRacialTraits = ObservableList<RacialTrait>.of(selectedRacialTraits ?? []),
        super(key: key);

  final racialTraitStore = GetIt.I<RacialTraitStore>();
  final ObservableList<RacialTrait> _selectedRacialTraits;
  final divider = const Divider(height: 0);

  void _toggleSelectedRacialTrait(RacialTrait newRacialTrait) {
    bool isAlreadySelected = _selectedRacialTraits.any((racialTrait) => racialTrait.id == newRacialTrait.id);
    if (isAlreadySelected) {
      _selectedRacialTraits.removeWhere((racialTrait) => racialTrait.id == newRacialTrait.id);
    } else {
      _selectedRacialTraits.add(newRacialTrait);
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
                        'Selecione os Traços Raciais',
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
                          onChanged: (value) => racialTraitStore.runFilter(value),
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
                  if (racialTraitStore.showProgress) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColors.grape_juice,
                        ),
                      ),
                    );
                  }
                  if (racialTraitStore.listRacialTrait.isEmpty) {
                    return const Expanded(
                      child: ListEmpty(
                        texto: "Nenhum Taço Racial Encontrado!",
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
                              if (index < racialTraitStore.listRacialTrait.length) {
                                final racialTrait = racialTraitStore.listSearch[index];
                                return InkWell(
                                  onTap: () {
                                    _toggleSelectedRacialTrait(racialTrait);
                                  },
                                  child: Observer(
                                    builder: (context) => Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedRacialTraits.any((selectedRacialTrait) => selectedRacialTrait.id == racialTrait.id)
                                            ? CustomColors.grape_juice.withAlpha(50)
                                            : null,
                                        border: racialTraitStore.listRacialTrait.length - 1 == index
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
                                          '${racialTrait.name!.toUpperCase()}\n${racialTrait.description}',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ),
                                  ),
                                );
                              }
                              racialTraitStore.loadNextPage();
                              return Center(
                                child: LinearProgressIndicator(
                                  color: CustomColors.grape_juice,
                                  backgroundColor: CustomColors.grape_juice.withAlpha(100),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => divider,
                            itemCount: racialTraitStore.itemCount,
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
                              Navigator.of(context).pop(_selectedRacialTraits);
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(color: CustomColors.alabaster),
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