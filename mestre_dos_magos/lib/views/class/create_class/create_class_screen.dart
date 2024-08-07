import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_combat_type.dart';
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
import '../../../models/class.dart';
import '../../../stores/list/class_store.dart';
import '../../../stores/create/create_class_store.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({Key? key, this.classe}) : super(key: key);

  final Class? classe;

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateClassStore createClassStore;
  final classStore = GetIt.I<ClassStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.classe != null;
    createClassStore = CreateClassStore(widget.classe);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createClassStore.savedOrUpdatedOrDeleted, () {
      classStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createClassStore.error, (error) {
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
        title: editing ? 'Editar Classe' : 'Cadastrar Classe',
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
                              TitleTextForm(title: 'Nome da Classe'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createClassStore.name,
                                  onChanged: createClassStore.setName,
                                  error: createClassStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição da Classe'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createClassStore.description,
                                  onChanged: createClassStore.setDescription,
                                  error: createClassStore.descriptionError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'HP por Nível'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createClassStore.hp_per_level,
                                  onChanged: createClassStore.setHpPerLevel,
                                  error: createClassStore.hpPerLevelError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Atributos Primários'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createClassStore.primary_attributes,
                                  onChanged: createClassStore.setPrimaryAttributes,
                                  error: createClassStore.primaryAttributesError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Tipo de Combate da Classe'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogCombatType(
                                          selectedCombatType: createClassStore.combat_type
                                        ),
                                      );
                                      if (result != null) {
                                        createClassStore.setCombatType(result);
                                      }
                                    },
                                    title: createClassStore.combat_type?.name ?? "Selecione o Tipo de Combate",
                                    borderColor: createClassStore.combatTypeError != null ? Colors.red.shade700 : Colors.grey.shade400,
                                    error: createClassStore.combatTypeError,
                                    clearOnPressed: null,
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
                              await createClassStore.deleteClass();
                            } : null,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createClassStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.coconut,
                                text: 'Salvar',
                                largura: screenSize.width * 0.6,
                                function: createClassStore.isFormValid ? () async {
                                  if (editing) {
                                    await createClassStore.editPressed();
                                  } else {
                                    await createClassStore.createPressed();
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
