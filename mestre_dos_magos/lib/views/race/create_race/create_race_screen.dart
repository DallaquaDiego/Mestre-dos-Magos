import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_racial_traits.dart';
import 'package:mestre_dos_magos/core/ui/components/patterned_buttom.dart';
import 'package:mestre_dos_magos/core/ui/components/title_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';

import '../../../stores/page_store.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_field.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../../../models/race.dart';
import '../../../stores/create/create_race_store.dart';
import '../../../stores/list/race_store.dart';

class CreateRaceScreen extends StatefulWidget {
  const CreateRaceScreen({Key? key, this.race}) : super(key: key);

  final Race? race;

  @override
  State<CreateRaceScreen> createState() => _CreateRaceScreenState();
}

class _CreateRaceScreenState extends State<CreateRaceScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateRaceStore createRaceStore;
  final raceStore = GetIt.I<RaceStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.race != null;
    createRaceStore = CreateRaceStore(widget.race);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createRaceStore.savedOrUpdatedOrDeleted, () {
      raceStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createRaceStore.error, (error) {
      if (error != null) {
        print(error);
      }
    });
  }

  //Ao sair do widget
  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  void backToPreviousScreen() {
    pageStore.setBlockPagination(false);
    Navigator.of(context).pop();
  }

  //Marcação da Tela
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Raça' : 'Cadastrar Raça',
        onBackButtonPressed: backToPreviousScreen,
      ),
      body: BodyContainer(
        child: Row(
          children: [
            const NavigationPanelWeb(),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: CustomColors.coconut,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              TitleTextForm(title: 'Nome da Raça'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createRaceStore.name,
                                  onChanged: createRaceStore.setName,
                                  error: createRaceStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição da Raça'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createRaceStore.description,
                                  onChanged: createRaceStore.setDescription,
                                  error: createRaceStore.descriptionError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Traços Raciais'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomField(
                                        onTap: () async {
                                          final result = await showDialog(
                                            context: context,
                                            builder: (context) => DialogRacialTraits(
                                                selectedRacialTraits: createRaceStore.selectedRacialTraits
                                            ),
                                          );
                                          if (result != null) {
                                            createRaceStore.addRacialTraits(result);
                                          }
                                        },
                                        title: createRaceStore.selectedRacialTraits.isNotEmpty
                                            ? "Confira os Traços Raciais Abaixo"
                                            : "Selecione os Traços Raciais",
                                        borderColor: Colors.grey.shade400,
                                        error: createRaceStore.racialTraitError,
                                        clearOnPressed: null,
                                      ),
                                      if (createRaceStore.selectedRacialTraits.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createRaceStore.selectedRacialTraits.map((racialTrait) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets.only(left: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.coconut,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: CustomColors.coconut),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        racialTrait.name!,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          createRaceStore.removeRacialTrait(racialTrait);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: PatternedButton(
                            color: Colors.red,
                            text: 'Excluir',
                            largura: screenSize.width * 0.3,
                            function: editing ? () async {
                              await createRaceStore.deleteRace();
                            } : null,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createRaceStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.coconut,
                                text: 'Salvar',
                                largura: screenSize.width * 0.6,
                                function: createRaceStore.isFormValid ? () async {
                                  if (editing) {
                                    await createRaceStore.editPressed();
                                  } else {
                                    await createRaceStore.createPressed();
                                  }
                                } : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
