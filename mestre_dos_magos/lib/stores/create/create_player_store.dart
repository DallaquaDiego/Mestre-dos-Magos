import 'dart:developer';

import 'package:mestre_dos_magos/models/item.dart';
import 'package:mestre_dos_magos/models/player.dart';
import 'package:mestre_dos_magos/models/spell.dart';
import 'package:mobx/mobx.dart';

import '../../models/class.dart';
import '../../models/race.dart';
import '../../models/sub_race.dart';
import '../../repositories/item_repository.dart';
import '../../repositories/player_repository.dart';
import '../../repositories/spell_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_player_store.g.dart';

class CreatePlayerStore = _CreatePlayerStore with _$CreatePlayerStore;

abstract class _CreatePlayerStore with Store {
  _CreatePlayerStore(this.player) {
    _name = player?.name ?? '';
    _age = player?.age.toString() ?? '';
    _hp = player?.hp.toString() ?? '';
    _level = player?.level.toString() ?? '';
    _cd = player?.cd.toString() ?? '';
    _ca = player?.ca.toString() ?? '';
    _strength = player?.strength.toString() ?? '';
    _constitution = player?.constitution.toString() ?? '';
    _dexterity = player?.dexterity.toString() ?? '';
    _intelligence = player?.intelligence.toString() ?? '';
    _wisdom = player?.wisdom.toString() ?? '';
    _charisma = player?.charisma.toString() ?? '';
    _classe = player?.classe;
    _race = player?.race;
    _sub_race = player?.sub_race;

    findItens().then((_) {
      _selectedItens = ObservableList<Item>.of(
        _listItens.where((item) =>
        player?.itens?.any((selectedItem) => selectedItem.id == item.id) ?? false),
      );
    });

    findSpells().then((_) {
      _selectedSpells = ObservableList<Spell>.of(
        _listSpells.where((spell) =>
        player?.spells?.any((selectedSpell) => selectedSpell.id == spell.id) ?? false),
      );
    });
  }

  late Player? player;

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
      return 'Campo obrigatório';
    } else if (_name.length < 3) {
      return 'Nome muito curto';
    } else {
      return ('Nome inválido');
    }
  }

  @readonly
  String _age = '';

  @action
  void setAge(String value) => _age = value;

  @computed
  bool get ageValid => int.tryParse(_age) != null && int.tryParse(_age)! >= 0;

  String? get ageError {
    if (!showErrors || ageValid) {
      return null;
    } else if (!ageValid){
      return 'Idade Inválida';
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
  String _level = '';

  @action
  void setLevel(String value) => _level = value;

  @computed
  bool get levelValid => int.tryParse(_level) != null && int.tryParse(_level)! >= 1;

  String? get levelError {
    if (!showErrors || levelValid) {
      return null;
    } else if (!levelValid){
      return 'Nível Inválido';
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _cd = '';

  @action
  void setCd(String value) => _cd = value;

  @computed
  bool get cdValid => int.tryParse(_cd) != null && int.tryParse(_cd)! >= 1;

  String? get cdError {
    if (!showErrors || cdValid) {
      return null;
    } else if (!cdValid){
      return 'Valor de CD Inválido';
    } else {
      return 'Campo Obrigatório';
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
  String _strength = '';

  @action
  void setStrength(String value) => _strength = value;

  @computed
  bool get strengthValid => int.tryParse(_strength) != null && int.tryParse(_strength)! >= 1 && int.tryParse(_strength)! <= 20;

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
  bool get constitutionValid => int.tryParse(_constitution) != null && int.tryParse(_constitution)! >= 1 && int.tryParse(_constitution)! <= 20;

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
  bool get dexterityValid => int.tryParse(_dexterity) != null && int.tryParse(_dexterity)! >= 1 && int.tryParse(_dexterity)! <= 20;

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
  bool get intelligenceValid => int.tryParse(_intelligence) != null && int.tryParse(_intelligence)! >= 1 && int.tryParse(_intelligence)! <= 20;

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
  bool get wisdomValid => int.tryParse(_wisdom) != null && int.tryParse(_wisdom)! >= 1 && int.tryParse(_wisdom)! <= 20;

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
  bool get charismaValid => int.tryParse(_charisma) != null && int.tryParse(_charisma)! >= 1 && int.tryParse(_charisma)! <= 20;

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
  Class? _classe;

  @action
  void setClass(Class value) => _classe = value;

  @computed
  bool get classValid => _classe != null;

  String? get classError {
    if (!showErrors || classValid) {
      return null;
    } else if (!classValid) {
      return 'Campo Obrigatório';
    } else {
      return ('Classe inválida');
    }
  }

  @readonly
  Race? _race;

  @action
  void setRace(Race value) => _race = value;

  @computed
  bool get raceValid => _race != null;

  String? get raceError {
    if (!showErrors || raceValid) {
      return null;
    } else if (!raceValid) {
      return 'Campo Obrigatório';
    } else {
      return ('Raça inválida');
    }
  }

  @readonly
  SubRace? _sub_race;

  @action
  void setSubRace(SubRace value) => _sub_race = value;

  @computed
  bool get subRaceValid => true;

  String? get subRaceError {
    if (!showErrors || subRaceValid) {
      return null;
    } else if (!subRaceValid) {
      return 'Campo Obrigatório';
    } else {
      return ('Sub-Raça inválida');
    }
  }

  @readonly
  ObservableList<Item> _selectedItens = ObservableList();

  @readonly
  ObservableList<Item> _listItens = ObservableList();

  @action
  void addItens(List<Item> newItens) {
    _selectedItens.clear();
    _selectedItens.addAll(newItens);
  }

  @action
  void removeItem(Item itemToRemove) {
    _selectedItens.removeWhere((item) => item.id == itemToRemove.id);
  }

  @computed
  bool get itensValid => _selectedItens.isNotEmpty;

  @computed
  String? get itensError {
    if (!showErrors || itensValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @readonly
  ObservableList<Spell> _selectedSpells = ObservableList();

  @readonly
  ObservableList<Spell> _listSpells = ObservableList();

  @action
  void addSpells(List<Spell> newSpells) {
    _selectedSpells.clear();
    _selectedSpells.addAll(newSpells);
  }

  @action
  void removeSpell(Spell spellToRemove) {
    _selectedSpells.removeWhere((spell) => spell.id == spellToRemove.id);
  }

  @computed
  bool get spellsValid => _selectedSpells.isNotEmpty;

  @computed
  String? get spellsError {
    if (!showErrors || spellsValid) {
      return null;
    } else {
      return 'Campo obrigatório';
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
  bool get isFormValid => nameValid && ageValid && hpValid &&
                          levelValid && cdValid && caValid &&
                          strengthValid && constitutionValid &&
                          dexterityValid && intelligenceValid &&
                          wisdomValid && charismaValid &&
                          classValid && raceValid && subRaceValid &&
                          itensValid && spellsValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createPlayer : null;

  dynamic get editPressed => isFormValid ? _editPlayer : null;

  Future<void> _createPlayer() async {
    setError(null);
    setLoading(true);

    print(_sub_race);

    player = Player(
      name: _name,
      age: int.parse(_age),
      hp: int.parse(_hp),
      level: int.parse(_level),
      cd: int.parse(_cd),
      ca: int.parse(_ca),
      strength: int.parse(_strength),
      constitution: int.parse(_constitution),
      dexterity: int.parse(_dexterity),
      intelligence: int.parse(_intelligence),
      wisdom: int.parse(_wisdom),
      charisma: int.parse(_charisma),
      classe: _classe!,
      race: _race!,
      sub_race: _sub_race,
      spells: _selectedSpells,
      itens: _selectedItens,
    );
    print(_sub_race);

    try {
      await PlayerRepository().createPlayer(player!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar player!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }


  @action
  Future<void> _editPlayer() async {
    setError(null);
    setLoading(true);

    player!.name = _name;
    player!.age = int.parse(_age);
    player!.hp = int.parse(_hp);
    player!.level = int.parse(_level);
    player!.cd = int.parse(_cd);
    player!.ca = int.parse(_ca);
    player!.strength = int.parse(_strength);
    player!.constitution = int.parse(_constitution);
    player!.dexterity = int.parse(_dexterity);
    player!.intelligence = int.parse(_intelligence);
    player!.wisdom = int.parse(_wisdom);
    player!.charisma = int.parse(_charisma);
    player!.classe = _classe!;
    player!.race = _race!;
    player!.sub_race = _sub_race;
    player!.spells = _selectedSpells;
    player!.itens = _selectedItens;

    try {
      await PlayerRepository().updatePlayer(player!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar player!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deletePlayer() async {
    setError(null);
    setLoading(true);

    try {
      await PlayerRepository().deletePlayer(player!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar player!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> findItens() async {
    setError(null);
    setLoading(true);

    try {
      final result = await ItemRepository().getAllItems();
      _listItens.clear();
      _listItens.addAll(result);
    } catch (e, s) {
      log('Store: Erro ao buscar Itens!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> findSpells() async {
    setError(null);
    setLoading(true);

    try {
      final result = await SpellRepository().getAllSpells();
      _listSpells.clear();
      _listSpells.addAll(result);
    } catch (e, s) {
      log('Store: Erro ao buscar Magias!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}