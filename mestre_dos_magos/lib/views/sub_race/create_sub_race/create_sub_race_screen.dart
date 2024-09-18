import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_racial_traits.dart';
import 'package:mestre_dos_magos/core/ui/components/patterned_buttom.dart';
import 'package:mestre_dos_magos/core/ui/components/title_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/models/sub_race.dart';
import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/components/dialogs/dialog_race.dart';
import '../../../stores/create/create_sub_race_store.dart';
import '../../../stores/list/sub_race_store.dart';
import '../../../stores/page_store.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_field.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../sub_race/sub_race_screen.dart';

class CreateSubRaceScreen extends StatefulWidget {
  const CreateSubRaceScreen({Key? key, this.subRace}) : super(key: key);

  final SubRace? subRace;

  @override
  State<CreateSubRaceScreen> createState() => _CreateSubRaceScreenState();
}

class _CreateSubRaceScreenState extends State<CreateSubRaceScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateSubRaceStore createSubRaceStore;
  final subRaceStore = GetIt.I<SubRaceStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.subRace != null;
    createSubRaceStore = CreateSubRaceStore(widget.subRace);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createSubRaceStore.savedOrUpdatedOrDeleted, () {
      subRaceStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createSubRaceStore.error, (error) {
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SubRaceScreen(),
      ),
    );
  }

  //Marcação da Tela
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Sub-Raça' : 'Cadastrar Sub-Raça',
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
                        color: CustomColors.dragon_blood,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              TitleTextForm(title: 'Nome da Sub-Raça'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSubRaceStore.name,
                                  onChanged: createSubRaceStore.setName,
                                  error: createSubRaceStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição da Sub-Raça'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSubRaceStore.description,
                                  onChanged: createSubRaceStore.setDescription,
                                  error: createSubRaceStore.descriptionError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Raça Primária'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogRace(
                                            selectedRace: createSubRaceStore.parent_race
                                        ),
                                      );
                                      if (result != null) {
                                        createSubRaceStore.setParentRace(result);
                                      }
                                    },
                                    title: createSubRaceStore.parent_race?.name ?? "Selecione a Raça Principal",
                                    borderColor: createSubRaceStore.parentRaceError != null ? Colors.red.shade700 : Colors.grey.shade400,
                                    error: createSubRaceStore.parentRaceError,
                                    clearOnPressed: null,
                                  ),
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
                                                selectedRacialTraits: createSubRaceStore.selectedRacialTraits
                                            ),
                                          );
                                          if (result != null) {
                                            createSubRaceStore.addRacialTraits(result);
                                          }
                                        },
                                        title: createSubRaceStore.selectedRacialTraits.isNotEmpty
                                            ? "Confira os Traços Raciais Abaixo"
                                            : "Selecione os Traços Raciais",
                                        borderColor: Colors.grey.shade400,
                                        error: createSubRaceStore.racialTraitError,
                                        clearOnPressed: null,
                                      ),
                                      if (createSubRaceStore.selectedRacialTraits.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createSubRaceStore.selectedRacialTraits.map((racialTrait) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets.only(left: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.dragon_blood,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: CustomColors.dragon_blood),
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
                                                          createSubRaceStore.removeRacialTrait(racialTrait);
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
                    child: editing ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: PatternedButton(
                            color: CustomColors.dragon_blood,
                            textColor: CustomColors.white_mist,
                            text: 'Excluir',
                            largura: screenSize.width * 0.3,
                            function: editing ? () async {
                              await createSubRaceStore.deleteSubRace();
                            } : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createSubRaceStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.ancient_gold,
                                text: 'Salvar',
                                largura: screenSize.width * 0.65,
                                function: createSubRaceStore.isFormValid ? () async {
                                  if (editing) {
                                    await createSubRaceStore.editPressed();
                                  } else {
                                    await createSubRaceStore.createPressed();
                                  }
                                } : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) : Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createSubRaceStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.ancient_gold,
                                text: 'Salvar',
                                largura: screenSize.width * 0.95,
                                function: createSubRaceStore.isFormValid ? () async {
                                  if (editing) {
                                    await createSubRaceStore.editPressed();
                                  } else {
                                    await createSubRaceStore.createPressed();
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
