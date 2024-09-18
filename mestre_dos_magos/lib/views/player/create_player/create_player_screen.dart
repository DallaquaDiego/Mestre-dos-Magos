import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mestre_dos_magos/core/ui/components/dialogs/dialog_sub_race.dart';
import 'package:mobx/mobx.dart';
import '../../../core/ui/components/custom_app_bar.dart';
import '../../../core/ui/components/custom_field.dart';
import '../../../core/ui/components/custom_form_field.dart';
import '../../../core/ui/components/dialogs/dialog_class.dart';
import '../../../core/ui/components/dialogs/dialog_itens.dart';
import '../../../core/ui/components/dialogs/dialog_race.dart';
import '../../../core/ui/components/dialogs/dialog_spells.dart';
import '../../../core/ui/components/title_text_form.dart';
import '../../../models/player.dart';
import '../../../stores/create/create_player_store.dart';
import '../../../stores/list/player_store.dart';
import '../../../stores/page_store.dart';
import '../../../core/ui/components/body_container.dart';
import '../../../core/ui/components/navigation_panel.dart';
import '../../../core/ui/theme/custom_colors.dart';
import '../player/player_screen.dart';

class CreatePlayerScreen extends StatefulWidget {
  const CreatePlayerScreen({Key? key, this.player}) : super(key: key);

  final Player? player;

  @override
  State<CreatePlayerScreen> createState() => _CreatePlayerScreenState();
}

class _CreatePlayerScreenState extends State<CreatePlayerScreen> with SingleTickerProviderStateMixin {
  late bool editing;
  final pageStore = GetIt.I<PageStore>();
  late final CreatePlayerStore createPlayerStore;
  final playerStore = GetIt.I<PlayerStore>();
  late ReactionDisposer reactionDisposer;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    pageStore.setBlockPagination(true);
    editing = widget.player != null;
    createPlayerStore = CreatePlayerStore(widget.player);

    _tabController = TabController(length: 2, vsync: this);

    when((_) => createPlayerStore.savedOrUpdatedOrDeleted, () {
      playerStore.refreshData();
      backToPreviousScreen();
    });

    reactionDisposer = reaction((_) => createPlayerStore.error, (error) {
      if (error != null) {
        print(error);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    reactionDisposer();
    super.dispose();
  }

  void backToPreviousScreen() {
    pageStore.setBlockPagination(false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlayerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: editing ? 'Editar Player' : 'Cadastrar Player',
        onBackButtonPressed: backToPreviousScreen,
      ),
      body: BodyContainer(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: CustomColors.dragon_blood,
              indicatorColor: CustomColors.dragon_blood,
              unselectedLabelColor: CustomColors.dragon_blood.withOpacity(0.35),
              tabs: const [
                Tab(text: 'Informações Básicas'),
                Tab(text: 'Classe, Raça, Magias e Inventário'),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  const NavigationPanelWeb(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Primeira Aba - Informações
                        SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TitleTextForm(title: 'Nome do Jogador', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createPlayerStore.name,
                                            onChanged: createPlayerStore.setName,
                                            error: createPlayerStore.nameError,
                                            secret: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TitleTextForm(title: 'Nível do Jogador', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createPlayerStore.level,
                                            onChanged: createPlayerStore.setLevel,
                                            error: createPlayerStore.levelError,
                                            secret: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TitleTextForm(title: 'Idade', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createPlayerStore.age,
                                            onChanged: createPlayerStore.setAge,
                                            error: createPlayerStore.ageError,
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
                                        TitleTextForm(title: 'HP', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createPlayerStore.hp,
                                            onChanged: createPlayerStore.setHp,
                                            error: createPlayerStore.hpError,
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
                                            initialvalue: createPlayerStore.ca,
                                            onChanged: createPlayerStore.setCa,
                                            error: createPlayerStore.caError,
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
                                        TitleTextForm(title: 'CD', textAlign: TextAlign.center),
                                        Observer(
                                          builder: (context) => CustomFormField(
                                            textAlign: TextAlign.center,
                                            initialvalue: createPlayerStore.cd,
                                            onChanged: createPlayerStore.setCd,
                                            error: createPlayerStore.cdError,
                                            secret: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Center(
                                child: Text(
                                  'Atributos',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: CustomColors.dragon_blood,
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
                                        color: CustomColors.dragon_blood.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Força', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createPlayerStore.strength,
                                              onChanged: createPlayerStore.setStrength,
                                              error: createPlayerStore.strengthError,
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
                                        color: CustomColors.dragon_blood.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Constituição', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createPlayerStore.constitution,
                                              onChanged: createPlayerStore.setConstitution,
                                              error: createPlayerStore.constitutionError,
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
                                        color: CustomColors.dragon_blood.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Destreza', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createPlayerStore.dexterity,
                                              onChanged: createPlayerStore.setDexterity,
                                              error: createPlayerStore.dexterityError,
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
                                        color: CustomColors.dragon_blood.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Inteligência', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createPlayerStore.intelligence,
                                              onChanged: createPlayerStore.setIntelligence,
                                              error: createPlayerStore.intelligenceError,
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
                                        color: CustomColors.dragon_blood.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Sabedoria', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createPlayerStore.wisdom,
                                              onChanged: createPlayerStore.setWisdom,
                                              error: createPlayerStore.wisdomError,
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
                                        color: CustomColors.dragon_blood.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          TitleTextForm(title: 'Carisma', textAlign: TextAlign.center),
                                          Observer(
                                            builder: (context) => CustomFormField(
                                              textAlign: TextAlign.center,
                                              initialvalue: createPlayerStore.charisma,
                                              onChanged: createPlayerStore.setCharisma,
                                              error: createPlayerStore.charismaError,
                                              secret: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 15),
                              TitleTextForm(title: 'Classe do Jogador'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogClass(
                                            selectedClass: createPlayerStore.classe
                                        ),
                                      );
                                      if (result != null) {
                                        createPlayerStore.setClass(result);
                                      }
                                    },
                                    title: createPlayerStore.classe?.name ?? "Selecione a Classe",
                                    borderColor: createPlayerStore.classError != null ? Colors.red.shade700 : CustomColors.dragon_blood.withAlpha(50),
                                    error: createPlayerStore.classError,
                                    clearOnPressed: null,
                                  ),
                                ),
                              ),
                              TitleTextForm(title: 'Raça do Jogador'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogRace(
                                            selectedRace: createPlayerStore.race
                                        ),
                                      );
                                      if (result != null) {
                                        createPlayerStore.setRace(result);
                                      }
                                    },
                                    title: createPlayerStore.race?.name ?? "Selecione a Raça",
                                    borderColor: createPlayerStore.raceError != null ? Colors.red.shade700 : CustomColors.dragon_blood.withAlpha(50),
                                    error: createPlayerStore.raceError,
                                    clearOnPressed: null,
                                  ),
                                ),
                              ),
                              TitleTextForm(title: 'Sub-Raça do Jogador'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                                child: Observer(
                                  builder: (context) => CustomField(
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => DialogSubRace(
                                            selectedSubRace: createPlayerStore.sub_race
                                        ),
                                      );
                                      if (result != null) {
                                        createPlayerStore.setSubRace(result);
                                      }
                                    },
                                    title: createPlayerStore.sub_race?.name ?? "Selecione a Sub-Raça",
                                    borderColor: createPlayerStore.subRaceError != null ? Colors.red.shade700 : CustomColors.dragon_blood.withAlpha(50),
                                    error: createPlayerStore.subRaceError,
                                    clearOnPressed: null,
                                  ),
                                ),
                              ),
                              TitleTextForm(title: 'Truques e Magias'),
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
                                            builder: (context) => DialogSpells(
                                                selectedSpells: createPlayerStore.selectedSpells
                                            ),
                                          );
                                          if (result != null) {
                                            createPlayerStore.addSpells(result);
                                          }
                                        },
                                        title: createPlayerStore.selectedSpells.isNotEmpty
                                            ? "Confira os Truques e Magias Abaixo"
                                            : "Selecione os Truques e Magias",
                                        borderColor: Colors.grey.shade400,
                                        error: createPlayerStore.spellsError,
                                        clearOnPressed: null,
                                      ),
                                      if (createPlayerStore.selectedSpells.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createPlayerStore.selectedSpells.map((spell) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 50,
                                                  padding: const EdgeInsets.only(left: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.dragon_blood,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: CustomColors.dragon_blood, width: 0.5),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          spell.name!,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () => createPlayerStore.removeSpell(spell),
                                                        child: const Icon(
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
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              TitleTextForm(title: 'Itens'),
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
                                            builder: (context) => DialogItens(
                                                selectedItens: createPlayerStore.selectedItens
                                            ),
                                          );
                                          if (result != null) {
                                            createPlayerStore.addItens(result);
                                          }
                                        },
                                        title: createPlayerStore.selectedItens.isNotEmpty
                                            ? "Confira os Itens Abaixo"
                                            : "Selecione os Itens",
                                        borderColor: Colors.grey.shade400,
                                        error: createPlayerStore.itensError,
                                        clearOnPressed: null,
                                      ),
                                      if (createPlayerStore.selectedItens.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: createPlayerStore.selectedItens.map((item) {
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
                                                        item.name!,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          createPlayerStore.removeItem(item);
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: editing ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton.extended(
            backgroundColor: CustomColors.dragon_blood,
            foregroundColor: CustomColors.white_mist,
            label: const Text('Excluir'),
            heroTag: 'Excluir',
            tooltip: 'Excluir',
            icon: const Icon(Icons.delete),
            onPressed: () async {
              if (editing) {
                await createPlayerStore.deletePlayer();
                backToPreviousScreen();
              }
            },
          ),
          const SizedBox(width: 32),
          FloatingActionButton.extended(
            backgroundColor: CustomColors.ancient_gold,
            foregroundColor: CustomColors.white_mist,
            label: const Text('Salvar'),
            heroTag: 'Salvar',
            tooltip: 'Salvar',
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (createPlayerStore.isFormValid) {
                if (editing) {
                  await createPlayerStore.editPressed();
                } else {
                  await createPlayerStore.createPressed();
                }
                backToPreviousScreen();
              }
            },
          ),
        ],
      ) : FloatingActionButton.extended(
        backgroundColor: CustomColors.ancient_gold,
        foregroundColor: CustomColors.white_mist,
        label: const Text('Salvar'),
        heroTag: 'Salvar',
        tooltip: 'Salvar',
        icon: const Icon(Icons.save),
        onPressed: () async {
          if (createPlayerStore.isFormValid) {
            if (editing) {
              await createPlayerStore.editPressed();
            } else {
              await createPlayerStore.createPressed();
            }
            backToPreviousScreen();
          }
        },
      ),
    );
  }
}
