import 'package:mestre_dos_magos/core/ui/components/patterned_buttom.dart';
import 'package:mestre_dos_magos/core/ui/components/title_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';

import '../../../models/racial_trait.dart';
import '../../../stores/create/create_racial_trait_store.dart';
import '../../../stores/list/racial_trait_store.dart';
import '../../../stores/page_store.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../racial_trait/racial_trait_screen.dart';

class CreateRacialTraitScreen extends StatefulWidget {
  const CreateRacialTraitScreen({Key? key, this.racialTrait}) : super(key: key);

  final RacialTrait? racialTrait;

  @override
  State<CreateRacialTraitScreen> createState() => _CreateRacialTraitScreenState();
}

class _CreateRacialTraitScreenState extends State<CreateRacialTraitScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateRacialTraitStore createRacialTraitStore;
  final racialTraitStore = GetIt.I<RacialTraitStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.racialTrait != null;
    createRacialTraitStore = CreateRacialTraitStore(widget.racialTrait);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createRacialTraitStore.savedOrUpdatedOrDeleted, () {
      racialTraitStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createRacialTraitStore.error, (error) {
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
        builder: (context) => RacialTraitScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Traço Racial' : 'Cadastrar Traço Racial',
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
                              TitleTextForm(title: 'Nome do Traço'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createRacialTraitStore.name,
                                  onChanged: createRacialTraitStore.setName,
                                  error: createRacialTraitStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição do Traço'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createRacialTraitStore.description,
                                  onChanged: createRacialTraitStore.setDescription,
                                  error: createRacialTraitStore.descriptionError,
                                  secret: false,
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
                              await createRacialTraitStore.deleteRacialTrait();
                            } : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createRacialTraitStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.ancient_gold,
                                text: 'Salvar',
                                largura: screenSize.width * 0.65,
                                function: createRacialTraitStore.isFormValid ? () async {
                                  if (editing) {
                                    await createRacialTraitStore.editPressed();
                                  } else {
                                    await createRacialTraitStore.createPressed();
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
                              onTap: () => createRacialTraitStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.ancient_gold,
                                text: 'Salvar',
                                largura: screenSize.width * 0.95,
                                function: createRacialTraitStore.isFormValid ? () async {
                                  if (editing) {
                                    await createRacialTraitStore.editPressed();
                                  } else {
                                    await createRacialTraitStore.createPressed();
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
