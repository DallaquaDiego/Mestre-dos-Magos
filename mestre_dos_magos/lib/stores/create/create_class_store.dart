import 'dart:developer';

import 'package:mestre_dos_magos/models/class.dart';
import 'package:mobx/mobx.dart';

import '../../models/combat_type.dart';
import '../../repositories/class_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_class_store.g.dart';

class CreateClassStore = _CreateClassStore with _$CreateClassStore;

abstract class _CreateClassStore with Store {
  _CreateClassStore(this.classe) {
    _name = classe?.name ?? '';
    _description = classe?.description ?? '';
    _combat_type = classe?.combat_type;
    _hp_per_level = classe?.hp_per_level ?? '';
    _primary_attributes = classe?.primary_attributes ?? '';
    _resistance_proficiency = classe?.resistance_proficiency ?? '';
    _weapon_and_armor_proficiency = classe?.weapon_and_armor_proficiency ?? '';
  }

  late Class? classe;

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
  String _description = '';

  @action
  void setDescription(String value) => _description = value;

  @computed
  bool get descriptionValid => _description.length >= 3;

  String? get descriptionError {
    if (!showErrors || descriptionValid) {
      return null;
    } else if (_description.isEmpty) {
      return 'Campo obrigatório';
    } else if (_description.length < 3) {
      return 'Descrição muito curta';
    } else {
      return ('Descrição inválida');
    }
  }

  @readonly
  String _primary_attributes = '';

  @action
  void setPrimaryAttributes(String value) => _primary_attributes = value;

  @computed
  bool get primaryAttributesValid => _primary_attributes.length >= 3;

  String? get primaryAttributesError {
    if (!showErrors || primaryAttributesValid) {
      return null;
    } else if (_primary_attributes.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return ('Atributos Primários inválidos');
    }
  }

  @readonly
  String _hp_per_level = '';

  @action
  void setHpPerLevel(String value) => _hp_per_level = value;

  @computed
  bool get hpPerLevelValid => _hp_per_level.length >= 3;

  String? get hpPerLevelError {
    if (!showErrors || hpPerLevelValid) {
      return null;
    } else if (_hp_per_level.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return ('Pontos de HP por Nível inválidos');
    }
  }

  @readonly
  String _resistance_proficiency = '';

  @action
  void setResistanceProficiency(String value) => _resistance_proficiency = value;

  @computed
  bool get resistanceProficiencyValid => _resistance_proficiency.length >= 3;

  String? get resistanceProficiencyError {
    if (!showErrors || resistanceProficiencyValid) {
      return null;
    } else if (_resistance_proficiency.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return ('Proficiências inválidas');
    }
  }

  @readonly
  String _weapon_and_armor_proficiency = '';

  @action
  void setWeaponAndArmorProficiency(String value) => _weapon_and_armor_proficiency = value;

  @computed
  bool get weaponAndArmorProficiencyValid => _weapon_and_armor_proficiency.length >= 3;

  String? get weaponAndArmorProficiencyError {
    if (!showErrors || weaponAndArmorProficiencyValid) {
      return null;
    } else if (_weapon_and_armor_proficiency.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return ('Proficiências inválidas');
    }
  }

  @readonly
  CombatType? _combat_type;

  @action
  void setCombatType(CombatType value) => _combat_type = value;

  @computed
  bool get combatTypeValid => _combat_type != null;

  String? get combatTypeError {
    if (!showErrors || combatTypeValid) {
      return null;
    } else if (!combatTypeValid) {
      return 'Campo obrigatório';
    } else {
      return ('Tipo de Combate inválido');
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
                          primaryAttributesValid && hpPerLevelValid &&
                          combatTypeValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createClass : null;

  dynamic get editPressed => isFormValid ? _editClass : null;

  Future<void> _createClass() async {
    setError(null);
    setLoading(true);

    classe = Class(
      name: _name,
      description: _description,
      hp_per_level: _hp_per_level,
      primary_attributes: _primary_attributes,
      resistance_proficiency:  _resistance_proficiency,
      weapon_and_armor_proficiency:  _weapon_and_armor_proficiency,
      combat_type: _combat_type!,
    );

    try {
      await ClassRepository().createClass(classe!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Classe!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editClass() async {
    setError(null);
    setLoading(true);

    classe!.name = _name;
    classe!.description = _description;
    classe!.hp_per_level = _hp_per_level;
    classe!.primary_attributes = _primary_attributes;
    classe!.resistance_proficiency = _resistance_proficiency;
    classe!.weapon_and_armor_proficiency = _weapon_and_armor_proficiency;
    classe!.combat_type = _combat_type!;

    try {
      await ClassRepository().updateClass(classe!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Classe!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteClass() async {
    setError(null);
    setLoading(true);

    try {
      await ClassRepository().deleteClass(classe!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar Classe!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}