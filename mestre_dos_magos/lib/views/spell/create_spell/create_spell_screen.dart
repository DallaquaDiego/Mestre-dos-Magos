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
import '../../../core/ui/components/dialogs/dialog_spell_category.dart';
import '../../../models/spell.dart';
import '../../../stores/create/create_spell_store.dart';
import '../../../stores/list/spell_store.dart';

class CreateSpellScreen extends StatefulWidget {
  const CreateSpellScreen({Key? key, this.spell}) : super(key: key);

  final Spell? spell;

  @override
  State<CreateSpellScreen> createState() => _CreateSpellScreenState();
}

class _CreateSpellScreenState extends State<CreateSpellScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateSpellStore createSpellStore;
  final spellStore = GetIt.I<SpellStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.spell != null;
    createSpellStore = CreateSpellStore(widget.spell);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createSpellStore.savedOrUpdatedOrDeleted, () {
      spellStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createSpellStore.error, (error) {
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
        title: editing ? 'Editar Magia' : 'Cadastrar Magia',
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
                        color: CustomColors.grape_juice,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              TitleTextForm(title: 'Nome da Magia'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.name,
                                  onChanged: createSpellStore.setName,
                                  error: createSpellStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição da Magia'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.description,
                                  onChanged: createSpellStore.setDescription,
                                  error: createSpellStore.descriptionError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Nível da Magia'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.spell_level,
                                  onChanged: createSpellStore.setSpellLevel,
                                  error: createSpellStore.spellLevelError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Duração da Magia'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.duration,
                                  onChanged: createSpellStore.setDuration,
                                  error: createSpellStore.durationError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Dano da Magia'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.damage,
                                  onChanged: createSpellStore.setDamage,
                                  error: createSpellStore.damageError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Efeitos da Magia em Oponentes'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.effect_on_foe  ,
                                  onChanged: createSpellStore.setEffectOnFoe,
                                  error: createSpellStore.effectOnFoeError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Efeitos da Magia em Aliados'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createSpellStore.effect_on_ally  ,
                                  onChanged: createSpellStore.setEffectOnAlly,
                                  error: createSpellStore.effectOnAllyError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Categoria da Magia'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogSpellCategory(
                                            selectedSpellCategory: createSpellStore.spell_category
                                        ),
                                      );
                                      if (result != null) {
                                        createSpellStore.setSpellCategory(result);
                                      }
                                    },
                                    title: createSpellStore.spell_category?.name ?? "Selecione a Categoria",
                                    borderColor: createSpellStore.spellCategoryError != null ? Colors.red.shade700 : Colors.grey.shade400,
                                    error: createSpellStore.spellCategoryError,
                                    clearOnPressed: null,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Truque',
                                    style: TextStyle(
                                      color: CustomColors.grape_juice,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Observer(
                                    builder: (context) => Checkbox(
                                      value: createSpellStore.isTrick,
                                      onChanged: (newValue) {
                                        createSpellStore.setIsTrick(newValue ?? false);
                                      },
                                    ),
                                  ),
                                ],
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
                            color: CustomColors.mystical_lilac,
                            textColor: CustomColors.grape_juice,
                            text: 'Excluir',
                            largura: screenSize.width * 0.3,
                            function: editing ? () async {
                              await createSpellStore.deleteSpell();
                            } : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createSpellStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.grape_juice,
                                text: 'Salvar',
                                largura: screenSize.width * 0.65,
                                function: createSpellStore.isFormValid ? () async {
                                  if (editing) {
                                    await createSpellStore.editPressed();
                                  } else {
                                    await createSpellStore.createPressed();
                                  }
                                } : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) : Expanded(
                      flex: 6,
                      child: Observer(
                        builder: (context) => GestureDetector(
                          onTap: () => createSpellStore.invalidSendPressed(),
                          child: PatternedButton(
                            color: CustomColors.grape_juice,
                            text: 'Salvar',
                            largura: screenSize.width * 0.95,
                            function: createSpellStore.isFormValid ? () async {
                              if (editing) {
                                await createSpellStore.editPressed();
                              } else {
                                await createSpellStore.createPressed();
                              }
                            } : null,
                          ),
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
    );
  }
}
