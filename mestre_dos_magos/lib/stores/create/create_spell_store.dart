import 'dart:developer';
import 'package:mestre_dos_magos/models/spell.dart';
import 'package:mobx/mobx.dart';
import '../../models/spell_category.dart';
import '../../repositories/spell_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_spell_store.g.dart';

class CreateSpellStore = _CreateSpellStore with _$CreateSpellStore;

abstract class _CreateSpellStore with Store {
  _CreateSpellStore(this.spell) {
    _name = spell?.name ?? '';
    _description = spell?.description ?? '';
    _isTrick = spell?.isTrick ?? false;
    _spell_level = spell?.spell_level.toString() ?? '';
    _duration = spell?.duration ?? '';
    _damage = spell?.damage ?? '';
    _effect_on_foe = spell?.effect_on_foe ?? '';
    _effect_on_ally = spell?.effect_on_ally ?? '';
    _spell_category = spell?.spell_category;
  }

  late Spell? spell;

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
  bool _isTrick = false;

  @action
  void setIsTrick(bool value) => _isTrick = value;

  @computed
  bool get isTrickValid => _isTrick != null;

  String? get isTrickError {
    if (!showErrors || isTrickValid) {
      return null;
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _spell_level = '';

  @action
  void setSpellLevel(String value) => _spell_level = value;

  @computed
  bool get spellLevelValid => int.tryParse(_spell_level) != null && int.tryParse(_spell_level)! >= 0 && int.tryParse(_spell_level)! < 10;

  String? get spellLevelError {
    if (!showErrors || spellLevelValid) {
      return null;
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _duration = '';

  @action
  void setDuration(String value) => _duration = value;

  @computed
  bool get durationValid => _duration.length >= 3;

  String? get durationError {
    if (!showErrors || durationValid) {
      return null;
    } else if (_duration.isEmpty) {
      return 'Campo Obrigatório';
    } else if (!durationValid) {
      return 'Duração muito curta';
    } else {
      return ('Duração inválida');
    }
  }

  @readonly
  String _damage = '';

  @action
  void setDamage(String value) => _damage = value;

  @computed
  bool get damageValid => true;

  String? get damageError {
    if (!showErrors || damageValid) {
      return null;
    } else {
      return ('Campo Obrigatório');
    }
  }

  @readonly
  String _effect_on_foe = '';

  @action
  void setEffectOnFoe(String value) => _effect_on_foe = value;

  @computed
  bool get effectOnFoeValid => true;

  String? get effectOnFoeError {
    if (!showErrors || effectOnFoeValid) {
      return null;
    } else {
      return ('Campo Obrigatório');
    }
  }

  @readonly
  String _effect_on_ally = '';

  @action
  void setEffectOnAlly(String value) => _effect_on_ally = value;

  @computed
  bool get effectOnAllyValid => true;

  String? get effectOnAllyError {
    if (!showErrors || effectOnAllyValid) {
      return null;
    } else {
      return ('Campo Obrigatório');
    }
  }

  @readonly
  SpellCategory? _spell_category;

  @action
  void setSpellCategory(SpellCategory value) => _spell_category = value;

  @computed
  bool get spellCategoryValid => _spell_category != null;

  String? get spellCategoryError {
    if (!showErrors || spellCategoryValid) {
      return null;
    } else if (!spellCategoryValid) {
      return 'Campo Obrigatório';
    } else {
      return ('Categoria inválida');
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
                          spellLevelValid && isTrickValid &&
                          spellCategoryValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createSpell : null;

  dynamic get editPressed => isFormValid ? _editSpell : null;

  Future<void> _createSpell() async {
    setError(null);
    setLoading(true);

    spell = Spell(
      name: _name,
      description: _description,
      isTrick: _isTrick,
      spell_level: int.parse(_spell_level),
      spell_category: _spell_category!,
      duration: _duration,
      damage: _damage,
      effect_on_foe: _effect_on_foe,
      effect_on_ally: _effect_on_ally,
    );

    try {
      await SpellRepository().createSpell(spell!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Magia!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editSpell() async {
    setError(null);
    setLoading(true);

    spell!.name = _name;
    spell!.description = _description;
    spell!.isTrick = _isTrick;
    spell!.spell_level = int.parse(_spell_level);
    spell!.spell_category = _spell_category!;
    spell!.duration = _duration;
    spell!.damage = _damage;
    spell!.effect_on_foe = _effect_on_foe;
    spell!.effect_on_ally = _effect_on_ally;


    try {
      await SpellRepository().updateSpell(spell!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Magia!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteSpell() async {
    setError(null);
    setLoading(true);

    try {
      await SpellRepository().deleteSpell(spell!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar Magia!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}