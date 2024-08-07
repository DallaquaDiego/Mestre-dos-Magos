// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_spell_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateSpellStore on _CreateSpellStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateSpellStore.nameValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateSpellStore.descriptionValid'))
      .value;
  Computed<bool>? _$isTrickValidComputed;

  @override
  bool get isTrickValid =>
      (_$isTrickValidComputed ??= Computed<bool>(() => super.isTrickValid,
              name: '_CreateSpellStore.isTrickValid'))
          .value;
  Computed<bool>? _$spellLevelValidComputed;

  @override
  bool get spellLevelValid =>
      (_$spellLevelValidComputed ??= Computed<bool>(() => super.spellLevelValid,
              name: '_CreateSpellStore.spellLevelValid'))
          .value;
  Computed<bool>? _$damageValidComputed;

  @override
  bool get damageValid =>
      (_$damageValidComputed ??= Computed<bool>(() => super.damageValid,
              name: '_CreateSpellStore.damageValid'))
          .value;
  Computed<bool>? _$effectOnFoeValidComputed;

  @override
  bool get effectOnFoeValid => (_$effectOnFoeValidComputed ??= Computed<bool>(
          () => super.effectOnFoeValid,
          name: '_CreateSpellStore.effectOnFoeValid'))
      .value;
  Computed<bool>? _$effectOnAllyValidComputed;

  @override
  bool get effectOnAllyValid => (_$effectOnAllyValidComputed ??= Computed<bool>(
          () => super.effectOnAllyValid,
          name: '_CreateSpellStore.effectOnAllyValid'))
      .value;
  Computed<bool>? _$spellCategoryValidComputed;

  @override
  bool get spellCategoryValid => (_$spellCategoryValidComputed ??=
          Computed<bool>(() => super.spellCategoryValid,
              name: '_CreateSpellStore.spellCategoryValid'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CreateSpellStore.isFormValid'))
          .value;
  Computed<dynamic>? _$createPressedComputed;

  @override
  dynamic get createPressed =>
      (_$createPressedComputed ??= Computed<dynamic>(() => super.createPressed,
              name: '_CreateSpellStore.createPressed'))
          .value;

  late final _$_nameAtom =
      Atom(name: '_CreateSpellStore._name', context: context);

  String get name {
    _$_nameAtom.reportRead();
    return super._name;
  }

  @override
  String get _name => name;

  @override
  set _name(String value) {
    _$_nameAtom.reportWrite(value, super._name, () {
      super._name = value;
    });
  }

  late final _$_descriptionAtom =
      Atom(name: '_CreateSpellStore._description', context: context);

  String get description {
    _$_descriptionAtom.reportRead();
    return super._description;
  }

  @override
  String get _description => description;

  @override
  set _description(String value) {
    _$_descriptionAtom.reportWrite(value, super._description, () {
      super._description = value;
    });
  }

  late final _$_isTrickAtom =
      Atom(name: '_CreateSpellStore._isTrick', context: context);

  bool get isTrick {
    _$_isTrickAtom.reportRead();
    return super._isTrick;
  }

  @override
  bool get _isTrick => isTrick;

  @override
  set _isTrick(bool value) {
    _$_isTrickAtom.reportWrite(value, super._isTrick, () {
      super._isTrick = value;
    });
  }

  late final _$_spell_levelAtom =
      Atom(name: '_CreateSpellStore._spell_level', context: context);

  String get spell_level {
    _$_spell_levelAtom.reportRead();
    return super._spell_level;
  }

  @override
  String get _spell_level => spell_level;

  @override
  set _spell_level(String value) {
    _$_spell_levelAtom.reportWrite(value, super._spell_level, () {
      super._spell_level = value;
    });
  }

  late final _$_damageAtom =
      Atom(name: '_CreateSpellStore._damage', context: context);

  String get damage {
    _$_damageAtom.reportRead();
    return super._damage;
  }

  @override
  String get _damage => damage;

  @override
  set _damage(String value) {
    _$_damageAtom.reportWrite(value, super._damage, () {
      super._damage = value;
    });
  }

  late final _$_effect_on_foeAtom =
      Atom(name: '_CreateSpellStore._effect_on_foe', context: context);

  String get effect_on_foe {
    _$_effect_on_foeAtom.reportRead();
    return super._effect_on_foe;
  }

  @override
  String get _effect_on_foe => effect_on_foe;

  @override
  set _effect_on_foe(String value) {
    _$_effect_on_foeAtom.reportWrite(value, super._effect_on_foe, () {
      super._effect_on_foe = value;
    });
  }

  late final _$_effect_on_allyAtom =
      Atom(name: '_CreateSpellStore._effect_on_ally', context: context);

  String get effect_on_ally {
    _$_effect_on_allyAtom.reportRead();
    return super._effect_on_ally;
  }

  @override
  String get _effect_on_ally => effect_on_ally;

  @override
  set _effect_on_ally(String value) {
    _$_effect_on_allyAtom.reportWrite(value, super._effect_on_ally, () {
      super._effect_on_ally = value;
    });
  }

  late final _$_spell_categoryAtom =
      Atom(name: '_CreateSpellStore._spell_category', context: context);

  SpellCategory? get spell_category {
    _$_spell_categoryAtom.reportRead();
    return super._spell_category;
  }

  @override
  SpellCategory? get _spell_category => spell_category;

  @override
  set _spell_category(SpellCategory? value) {
    _$_spell_categoryAtom.reportWrite(value, super._spell_category, () {
      super._spell_category = value;
    });
  }

  late final _$_savedOrUpdatedOrDeletedAtom = Atom(
      name: '_CreateSpellStore._savedOrUpdatedOrDeleted', context: context);

  bool get savedOrUpdatedOrDeleted {
    _$_savedOrUpdatedOrDeletedAtom.reportRead();
    return super._savedOrUpdatedOrDeleted;
  }

  @override
  bool get _savedOrUpdatedOrDeleted => savedOrUpdatedOrDeleted;

  @override
  set _savedOrUpdatedOrDeleted(bool value) {
    _$_savedOrUpdatedOrDeletedAtom
        .reportWrite(value, super._savedOrUpdatedOrDeleted, () {
      super._savedOrUpdatedOrDeleted = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_CreateSpellStore._loading', context: context);

  bool get loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  bool get _loading => loading;

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_CreateSpellStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$showErrorsAtom =
      Atom(name: '_CreateSpellStore.showErrors', context: context);

  @override
  bool get showErrors {
    _$showErrorsAtom.reportRead();
    return super.showErrors;
  }

  @override
  set showErrors(bool value) {
    _$showErrorsAtom.reportWrite(value, super.showErrors, () {
      super.showErrors = value;
    });
  }

  late final _$_editSpellAsyncAction =
      AsyncAction('_CreateSpellStore._editSpell', context: context);

  @override
  Future<void> _editSpell() {
    return _$_editSpellAsyncAction.run(() => super._editSpell());
  }

  late final _$deleteSpellAsyncAction =
      AsyncAction('_CreateSpellStore.deleteSpell', context: context);

  @override
  Future<void> deleteSpell() {
    return _$deleteSpellAsyncAction.run(() => super.deleteSpell());
  }

  late final _$_CreateSpellStoreActionController =
      ActionController(name: '_CreateSpellStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsTrick(bool value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setIsTrick');
    try {
      return super.setIsTrick(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpellLevel(String value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setSpellLevel');
    try {
      return super.setSpellLevel(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDamage(String value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setDamage');
    try {
      return super.setDamage(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEffectOnFoe(String value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setEffectOnFoe');
    try {
      return super.setEffectOnFoe(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEffectOnAlly(String value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setEffectOnAlly');
    try {
      return super.setEffectOnAlly(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpellCategory(SpellCategory value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setSpellCategory');
    try {
      return super.setSpellCategory(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedOrUpdatedOrDeleted(bool value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setSavedOrUpdatedOrDeleted');
    try {
      return super.setSavedOrUpdatedOrDeleted(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateSpellStoreActionController.startAction(
        name: '_CreateSpellStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateSpellStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
showErrors: ${showErrors},
nameValid: ${nameValid},
descriptionValid: ${descriptionValid},
isTrickValid: ${isTrickValid},
spellLevelValid: ${spellLevelValid},
damageValid: ${damageValid},
effectOnFoeValid: ${effectOnFoeValid},
effectOnAllyValid: ${effectOnAllyValid},
spellCategoryValid: ${spellCategoryValid},
isFormValid: ${isFormValid},
createPressed: ${createPressed}
    ''';
  }
}
