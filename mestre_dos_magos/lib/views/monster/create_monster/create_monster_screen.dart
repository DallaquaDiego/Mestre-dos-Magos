import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_monster_actions.dart';
import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_monster_legendary_actions.dart';
import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_monster_skills.dart';
import 'package:mestre_dos_magos/core/ui/components/patterned_buttom.dart';
import 'package:mestre_dos_magos/core/ui/components/title_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/ui/components/body_container.dart';
import '../../../../core/ui/components/navigation_panel.dart';
import '../../../../core/ui/theme/custom_colors.dart';
import 'package:mobx/mobx.dart';
import '../../../core/ui/components/custom_field.dart';
import '../../../models/monster.dart';
import '../../../stores/create/create_monster_store.dart';
import '../../../stores/list/monster_store.dart';
import '../../../stores/page_store.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../monster/monster_screen.dart';

class CreateMonsterScreen extends StatefulWidget {
  const CreateMonsterScreen({Key? key, this.monster}) : super(key: key);

  final Monster? monster;

  @override
  State<CreateMonsterScreen> createState() => _CreateMonsterScreenState();
}

class _CreateMonsterScreenState extends State<CreateMonsterScreen> {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreateMonsterStore createMonsterStore;
  final monsterStore = GetIt.I<MonsterStore>();
  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.monster != null;
    createMonsterStore = CreateMonsterStore(widget.monster);

    //QUANDO SALVAR COM SUCESSO, VOLTA PARA A TELA ANTERIOR E RECARREGA OS DADOS
    when((_) => createMonsterStore.savedOrUpdatedOrDeleted, () {
      monsterStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createMonsterStore.error, (error) {
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
        builder: (context) => MonsterScreen(),
      ),
    );
  }

  //Marcação da Tela
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Monstro' : 'Cadastrar Monstro',
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
                              TitleTextForm(title: 'Nome do Monstro'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createMonsterStore.name,
                                  onChanged: createMonsterStore.setName,
                                  error: createMonsterStore.nameError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Descrição do Monstro'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createMonsterStore.description,
                                  onChanged: createMonsterStore.setDescription,
                                  error: createMonsterStore.descriptionError,
                                  secret: false,
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TitleTextForm(title: 'HP', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createMonsterStore.hp,
                                            onChanged: createMonsterStore.setHp,
                                            error: createMonsterStore.hpError,
                                            secret: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TitleTextForm(title: 'Nível de Desafio', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createMonsterStore.challenge_level,
                                            onChanged: createMonsterStore.setChallengeLevel,
                                            error: createMonsterStore.challengeLevelError,
                                            secret: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TitleTextForm(title: 'CA', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createMonsterStore.ca,
                                            onChanged: createMonsterStore.setCa,
                                            error: createMonsterStore.caError,
                                            secret: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              TitleTextForm(title: 'Testes de Resistência'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createMonsterStore.endurance_tests,
                                  onChanged: createMonsterStore.setEnduranceTests,
                                  error: createMonsterStore.enduranceTestsError,
                                  secret: false,
                                ),
                              ),

                              TitleTextForm(title: 'Perícias'),
                              Observer(
                                builder: (context) => CustomFormField(
                                  initialvalue: createMonsterStore.expertise,
                                  onChanged: createMonsterStore.setExpertise,
                                  error: createMonsterStore.expertiseError,
                                  secret: false,
                                ),
                              ),

                              const SizedBox(height: 12),
                              const Center(
                                child: Text(
                                  'Atributos',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: CustomColors.grape_juice,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.grape_juice.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Força', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createMonsterStore.strength,
                                              onChanged: createMonsterStore.setStrength,
                                              error: createMonsterStore.strengthError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.grape_juice.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Constituição', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createMonsterStore.constitution,
                                              onChanged: createMonsterStore.setConstitution,
                                              error: createMonsterStore.constitutionError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.grape_juice.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Destreza', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createMonsterStore.dexterity,
                                              onChanged: createMonsterStore.setDexterity,
                                              error: createMonsterStore.dexterityError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.grape_juice.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Inteligência', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createMonsterStore.intelligence,
                                              onChanged: createMonsterStore.setIntelligence,
                                              error: createMonsterStore.intelligenceError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.grape_juice.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Sabedoria', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createMonsterStore.wisdom,
                                              onChanged: createMonsterStore.setWisdom,
                                              error: createMonsterStore.wisdomError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: CustomColors.grape_juice.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Carisma', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createMonsterStore.charisma,
                                              onChanged: createMonsterStore.setCharisma,
                                              error: createMonsterStore.charismaError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),
                              const Center(
                                child: Text(
                                  'Habilidades e Ações',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: CustomColors.grape_juice,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              TitleTextForm(title: 'Habilidades'),
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
                                            builder: (context) => DialogMonsterSkills(
                                                selectedSkills: createMonsterStore.selectedSkills
                                            ),
                                          );
                                          if (result != null) {
                                            createMonsterStore.addSkills(result);
                                          }
                                        },
                                        title: createMonsterStore.selectedSkills.isNotEmpty
                                            ? "Confira as Habilidades Abaixo"
                                            : "Selecione as Habilidades do Monstro",
                                        borderColor: Colors.grey.shade400,
                                        error: createMonsterStore.skillsError,
                                        clearOnPressed: null,
                                      ),
                                      if (createMonsterStore.selectedSkills.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createMonsterStore.selectedSkills.map((skill) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets.only(left: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.grape_juice,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: CustomColors.grape_juice),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        skill.name!,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          createMonsterStore.removeSkill(skill);
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

                              TitleTextForm(title: 'Ações'),
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
                                            builder: (context) => DialogMonsterActions(
                                                selectedActions: createMonsterStore.selectedActions
                                            ),
                                          );
                                          if (result != null) {
                                            createMonsterStore.addActions(result);
                                          }
                                        },
                                        title: createMonsterStore.selectedActions.isNotEmpty
                                            ? "Confira as Ações Abaixo"
                                            : "Selecione as Ações do Monstro",
                                        borderColor: Colors.grey.shade400,
                                        error: createMonsterStore.actionsError,
                                        clearOnPressed: null,
                                      ),
                                      if (createMonsterStore.selectedActions.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createMonsterStore.selectedActions.map((action) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets.only(left: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.grape_juice,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: CustomColors.grape_juice),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        action.name!,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          createMonsterStore.removeAction(action);
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

                              TitleTextForm(title: 'Ações Lendárias'),
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
                                            builder: (context) => DialogMonsterLegendaryActions(
                                              selectedActions: createMonsterStore.selectedLegendaryActions
                                            ),
                                          );
                                          if (result != null) {
                                            createMonsterStore.addLegendaryActions(result);
                                          }
                                        },
                                        title: createMonsterStore.selectedLegendaryActions.isNotEmpty
                                            ? "Confira as Ações Lendárias Abaixo"
                                            : "Selecione as Ações Lendárias do Monstro",
                                        borderColor: Colors.grey.shade400,
                                        error: createMonsterStore.legendaryActionsError,
                                        clearOnPressed: null,
                                      ),
                                      if (createMonsterStore.selectedLegendaryActions.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createMonsterStore.selectedLegendaryActions.map((legendaryAction) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets.only(left: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.grape_juice,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: CustomColors.grape_juice),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        legendaryAction.name!,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          createMonsterStore.removeLegendaryAction(legendaryAction);
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
                            color: CustomColors.mystical_lilac,
                            textColor: CustomColors.grape_juice,
                            text: 'Excluir',
                            largura: screenSize.width * 0.3,
                            function: editing ? () async {
                              await createMonsterStore.deleteMonster();
                            } : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 6,
                          child: Observer(
                            builder: (context) => GestureDetector(
                              onTap: () => createMonsterStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.grape_juice,
                                text: 'Salvar',
                                largura: screenSize.width * 0.65,
                                function: createMonsterStore.isFormValid ? () async {
                                  if (editing) {
                                    await createMonsterStore.editPressed();
                                  } else {
                                    await createMonsterStore.createPressed();
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
                              onTap: () => createMonsterStore.invalidSendPressed(),
                              child: PatternedButton(
                                color: CustomColors.grape_juice,
                                text: 'Salvar',
                                largura: screenSize.width * 0.95,
                                function: createMonsterStore.isFormValid ? () async {
                                  if (editing) {
                                    await createMonsterStore.editPressed();
                                  } else {
                                    await createMonsterStore.createPressed();
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
