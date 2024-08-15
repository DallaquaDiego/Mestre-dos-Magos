import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../models/sub_race.dart';
import '../../../../stores/list/sub_race_store.dart';
import '../../theme/custom_colors.dart';
import '../list_empty.dart';

class DialogSubRace extends StatelessWidget {
  DialogSubRace({Key? key, this.selectedSubRace}) : super(key: key);

  final subRaceStore = GetIt.I<SubRaceStore>();
  final SubRace? selectedSubRace;

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
                    'Selecione a Sub-Raça',
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
                    color: CustomColors.grape_juice,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    onChanged: (value) => subRaceStore.runFilter(value),
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
          }),
          Observer(
            builder: (context) {
              if (subRaceStore.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.grape_juice,
                    ),
                  ),
                );
              }

              if (subRaceStore.listSubRace.isEmpty) {
                return const Expanded(
                  child: ListEmpty(
                    texto: "Nenhuma Sub-Raça Cadastrada.",
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index < subRaceStore.listSearch.length) {
                      final subRace = subRaceStore.listSearch[index];

                      return InkWell(
                        onTap: () => Navigator.of(context).pop(subRace),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: subRace.id == selectedSubRace?.id
                                ? CustomColors.grape_juice.withAlpha(50)
                                : null,
                            border: subRaceStore.listSearch.length - 1 == index
                                ? Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            )
                                : null,
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            subRace.name!,
                          ),
                        ),
                      );
                    }
                    subRaceStore.loadNextPage();
                    return Center(
                      child: LinearProgressIndicator(
                        color: CustomColors.grape_juice,
                        backgroundColor: CustomColors.grape_juice.withAlpha(100),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => divider,
                  itemCount: subRaceStore.listSearch.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
