import 'dart:developer';
import 'package:mestre_dos_magos/models/monster.dart';
import 'package:mestre_dos_magos/models/monster_action.dart';
import 'package:mestre_dos_magos/models/monster_legendary_action.dart';
import 'package:mestre_dos_magos/models/monster_skill.dart';
import 'package:mestre_dos_magos/repositories/monster_action_repository.dart';
import 'package:mestre_dos_magos/repositories/monster_legendary_action_repository.dart';
import 'package:mobx/mobx.dart';
import '../../repositories/monster_repository.dart';
import '../../repositories/monster_skill_repository.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_monster_store.g.dart';

class CreateMonsterStore = _CreateMonsterStore with _$CreateMonsterStore;

abstract class _CreateMonsterStore with Store {
  _CreateMonsterStore(this.monster) {
    _name = monster?.name ?? '';
    _description = monster?.description ?? '';
    _ca = monster?.ca.toString() ?? '';
    _hp = monster?.hp.toString() ?? '';
    _current_hp = monster?.current_hp.toString() ?? '';
    _endurance_tests = monster?.endurance_tests ?? '';
    _expertise = monster?.expertise ?? '';
    _challenge_level = monster?.challenge_level.toString() ?? '';
    _strength = monster?.strength.toString() ?? '';
    _constitution = monster?.constitution.toString() ?? '';
    _dexterity = monster?.dexterity.toString() ?? '';
    _intelligence = monster?.intelligence.toString() ?? '';
    _wisdom = monster?.wisdom.toString() ?? '';
    _charisma = monster?.charisma.toString() ?? '';

    findSkills().then((_) {
      _selectedSkills = ObservableList<MonsterSkill>.of(
        _listSkills.where((skill) =>
        monster?.skills?.any((selectedSkill) => selectedSkill.id == skill.id) ?? false),
      );
    });

    findActions().then((_) {
      _selectedActions = ObservableList<MonsterAction>.of(
        _listActions.where((action) =>
        monster?.actions?.any((selectedAction) => selectedAction.id == action.id) ?? false),
      );
    });

    findLegendaryActions().then((_) {
      _selectedLegendaryActions = ObservableList<MonsterLegendaryAction>.of(
        _listLegendaryAction.where((legendaryAction) =>
        monster?.legendary_actions?.any((selectedLegendaryAction) => selectedLegendaryAction.id == legendaryAction.id) ?? false),
      );
    });
  }

  late Monster? monster;

  @readonly
  String _name = '';

  @action
  void setName(String value) => _name = value;

  @computed
  bool get nameValid => _name.length >= 3;

  String? get nameError {
    if (!showErrors || nameValid) {
      return null;
    } else if (_name.isEmpty) {
      return 'Campo Obrigatório';
    } else if (_name.length < 3) {
      return 'Nome muito curto';
    } else {
      return ('Nome inválido');
    }
  }

  @readonly
  String _description = '';

  @action
  void setDescription(String value) => _description = value;

  @computed
  bool get descriptionValid => _description.length >= 3;

  String? get descriptionError {
    if (!showErrors || descriptionValid) {
      return null;
    } else if (_description.isEmpty) {
      return 'Campo Obrigatório';
    } else if (_description.length < 3) {
      return 'Descrição muito curta';
    } else {
      return ('Descrição inválida');
    }
  }

  @readonly
  String _ca = '';

  @action
  void setCa(String value) => _ca = value;

  @computed
  bool get caValid => int.tryParse(_ca) != null && int.tryParse(_ca)! >= 1;

  String? get caError {
    if (!showErrors || caValid) {
      return null;
    } else if (!caValid){
      return 'Valor de CA Inválido';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _hp = '';

  @action
  void setHp(String value) => _hp = value;

  @computed
  bool get hpValid => int.tryParse(_hp) != null && int.tryParse(_hp)! >= 0;

  String? get hpError {
    if (!showErrors || hpValid) {
      return null;
    } else if (!hpValid){
      return 'HP Inválido';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _current_hp = '';

  @action
  void setCurrentHp(String value) => _current_hp = value;

  @computed
  bool get currentHpValid => int.tryParse(_current_hp) != null && int.tryParse(_current_hp)! >= 0;

  String? get currentHpError {
    if (!showErrors || currentHpValid) {
      return null;
    } else if (!hpValid){
      return 'HP Atual Inválido';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _endurance_tests = '';

  @action
  void setEnduranceTests(String value) => _endurance_tests = value;

  @computed
  bool get enduranceTestsValid => _endurance_tests.length >= 3;

  String? get enduranceTestsError {
    if (!showErrors || enduranceTestsValid) {
      return null;
    } else if (_endurance_tests.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return ('Testes de Resistência inválidos');
    }
  }

  @readonly
  String _expertise = '';

  @action
  void setExpertise(String value) => _expertise = value;

  @computed
  bool get expertiseValid => _expertise.length >= 3;

  String? get expertiseError {
    if (!showErrors || expertiseValid) {
      return null;
    } else if (_expertise.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return ('Perícias inválidos');
    }
  }

  @readonly
  String _challenge_level = '';

  @action
  void setChallengeLevel(String value) => _challenge_level = value;

  @computed
  bool get challengeLevelValid => int.tryParse(_challenge_level) != null && int.tryParse(_challenge_level)! >= 1;

  String? get challengeLevelError {
    if (!showErrors || challengeLevelValid) {
      return null;
    } else if (_challenge_level.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return ('Nível de Desafio inválido');
    }
  }

  @readonly
  ObservableList<MonsterSkill> _selectedSkills = ObservableList();

  @readonly
  ObservableList<MonsterSkill> _listSkills = ObservableList();

  @action
  void addSkills(List<MonsterSkill> newSkills) {
    _selectedSkills.clear();
    _selectedSkills.addAll(newSkills);
  }

  @action
  void removeSkill(MonsterSkill skillToRemove) {
    _selectedSkills.removeWhere((skill) => skill.id == skillToRemove.id);
  }

  @computed
  bool get skillsValid => true;

  @computed
  String? get skillsError {
    if (!showErrors || skillsValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @readonly
  ObservableList<MonsterAction> _selectedActions = ObservableList();

  @readonly
  ObservableList<MonsterAction> _listActions = ObservableList();

  @action
  void addActions(List<MonsterAction> newActions) {
    _selectedActions.clear();
    _selectedActions.addAll(newActions);
  }

  @action
  void removeAction(MonsterAction actionToRemove) {
    _selectedActions.removeWhere((action) => action.id == actionToRemove.id);
  }

  @computed
  bool get actionsValid => _selectedActions.isNotEmpty;

  @computed
  String? get actionsError {
    if (!showErrors || actionsValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @readonly
  ObservableList<MonsterLegendaryAction> _selectedLegendaryActions = ObservableList();

  @readonly
  ObservableList<MonsterLegendaryAction> _listLegendaryAction = ObservableList();

  @action
  void addLegendaryActions(List<MonsterLegendaryAction> newLegendaryActions) {
    _selectedLegendaryActions.clear();
    _selectedLegendaryActions.addAll(newLegendaryActions);
  }

  @action
  void removeLegendaryAction(MonsterLegendaryAction legendaryActionToRemove) {
    _selectedLegendaryActions.removeWhere((legendaryAction) => legendaryAction.id == legendaryActionToRemove.id);
  }

  @computed
  bool get legendaryActionsValid => true;

  @computed
  String? get legendaryActionsError {
    if (!showErrors || legendaryActionsValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @readonly
  String _strength = '';

  @action
  void setStrength(String value) => _strength = value;

  @computed
  bool get strengthValid => int.tryParse(_strength) != null && int.tryParse(_strength)! >= 1;

  String? get strengthError {
    if (!showErrors || strengthValid) {
      return null;
    } else if (!strengthValid){
      return 'Valor de Força Inválida';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _constitution = '';

  @action
  void setConstitution(String value) => _constitution = value;

  @computed
  bool get constitutionValid => int.tryParse(_constitution) != null && int.tryParse(_constitution)! >= 1;

  String? get constitutionError {
    if (!showErrors || constitutionValid) {
      return null;
    } else if (!constitutionValid){
      return 'Valor de Constituição Inválida';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _dexterity = '';

  @action
  void setDexterity(String value) => _dexterity = value;

  @computed
  bool get dexterityValid => int.tryParse(_dexterity) != null && int.tryParse(_dexterity)! >= 1;

  String? get dexterityError {
    if (!showErrors || dexterityValid) {
      return null;
    } else if (!dexterityValid){
      return 'Valor de Destreza Inválida';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _intelligence = '';

  @action
  void setIntelligence(String value) => _intelligence = value;

  @computed
  bool get intelligenceValid => int.tryParse(_intelligence) != null && int.tryParse(_intelligence)! >= 1;

  String? get intelligenceError {
    if (!showErrors || intelligenceValid) {
      return null;
    } else if (!intelligenceValid){
      return 'Valor de Inteligência Inválida';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _wisdom = '';

  @action
  void setWisdom(String value) => _wisdom = value;

  @computed
  bool get wisdomValid => int.tryParse(_wisdom) != null && int.tryParse(_wisdom)! >= 1;

  String? get wisdomError {
    if (!showErrors || wisdomValid) {
      return null;
    } else if (!wisdomValid){
      return 'Valor de Sabedoria Inválido';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _charisma = '';

  @action
  void setCharisma(String value) => _charisma = value;

  @computed
  bool get charismaValid => int.tryParse(_charisma) != null && int.tryParse(_charisma)! >= 1;

  String? get charismaError {
    if (!showErrors || charismaValid) {
      return null;
    } else if (!charismaValid){
      return 'Valor de Carisma Inválido';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  bool _savedOrUpdatedOrDeleted = false;

  @action
  void setSavedOrUpdatedOrDeleted(bool value) => _savedOrUpdatedOrDeleted = value;

  @readonly
  bool _loading = false;

  @action
  void setLoading(bool value) => _loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @computed
  bool get isFormValid => nameValid && descriptionValid &&
                          caValid && hpValid &&  enduranceTestsValid &&
                          expertiseValid && challengeLevelValid &&
                          skillsValid && actionsValid && legendaryActionsValid &&
                          strengthValid && constitutionValid &&
                          dexterityValid && intelligenceValid &&
                          wisdomValid && charismaValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createMonster : null;

  dynamic get editPressed => isFormValid ? editMonster : null;

  Future<void> _createMonster() async {
    setError(null);
    setLoading(true);

    monster = Monster(
      name: _name,
      description: _description,
      ca: int.parse(_ca),
      hp: int.parse(_hp),
      current_hp: int.parse(_hp),
      endurance_tests: _endurance_tests,
      expertise: _expertise,
      challenge_level: int.parse(_challenge_level),
      skills: _selectedSkills,
      actions: _selectedActions,
      legendary_actions: _selectedLegendaryActions,
      strength: int.parse(_strength),
      constitution: int.parse(_constitution),
      dexterity: int.parse(_dexterity),
      intelligence: int.parse(_intelligence),
      wisdom: int.parse(_wisdom),
      charisma: int.parse(_charisma),
    );

    try {
      await MonsterRepository().createMonster(monster!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Monstro!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> editMonster() async {
    setError(null);
    setLoading(true);

    monster!.name = _name;
    monster!.description = _description;
    monster!.ca = int.parse(_ca);
    monster!.hp = int.parse(_hp);
    monster!.current_hp = int.parse(_current_hp);
    monster!.endurance_tests = _endurance_tests;
    monster!.expertise = _expertise;
    monster!.challenge_level = int.parse(_challenge_level);
    monster!.skills = _selectedSkills;
    monster!.actions = _selectedActions;
    monster!.legendary_actions = _selectedLegendaryActions;
    monster!.strength = int.parse(_strength);
    monster!.constitution = int.parse(_constitution);
    monster!.dexterity = int.parse(_dexterity);
    monster!.intelligence = int.parse(_intelligence);
    monster!.wisdom = int.parse(_wisdom);
    monster!.charisma = int.parse(_charisma);


    try {
      await MonsterRepository().updateMonster(monster!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Monstro!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteMonster() async {
    setError(null);
    setLoading(true);

    try {
      await MonsterRepository().deleteMonster(monster!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar Monstro!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> findSkills() async {
    setError(null);
    setLoading(true);

    try {
      final result = await MonsterSkillRepository().getAllSkills();
      _listSkills.clear();
      _listSkills.addAll(result);
    } catch (e, s) {
      log('Store: Erro ao encontrar Habilidades dos Monstros!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> findActions() async {
    setError(null);
    setLoading(true);

    try {
      final result = await MonsterActionRepository().getAllActions();
      _listActions.clear();
      _listActions.addAll(result);
    } catch (e, s) {
      log('Store: Erro ao encontrar Ações dos Monstros!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> findLegendaryActions() async {
    setError(null);
    setLoading(true);

    try {
      final result = await MonsterLegendaryActionRepository().getAllLegendaryActions();
      _listLegendaryAction.clear();
      _listLegendaryAction.addAll(result);
    } catch (e, s) {
      log('Store: Erro ao encontrar Ações Lendárias dos Monstros!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}