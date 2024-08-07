// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sub_race_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateSubRaceStore on _CreateSubRaceStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateSubRaceStore.nameValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateSubRaceStore.descriptionValid'))
      .value;
  Computed<bool>? _$parentRaceValidComputed;

  @override
  bool get parentRaceValid =>
      (_$parentRaceValidComputed ??= Computed<bool>(() => super.parentRaceValid,
              name: '_CreateSubRaceStore.parentRaceValid'))
          .value;
  Computed<bool>? _$racialTraitValidComputed;

  @override
  bool get racialTraitValid => (_$racialTraitValidComputed ??= Computed<bool>(
          () => super.racialTraitValid,
          name: '_CreateSubRaceStore.racialTraitValid'))
      .value;
  Computed<String?>? _$racialTraitErrorComputed;

  @override
  String? get racialTraitError => (_$racialTraitErrorComputed ??=
          Computed<String?>(() => super.racialTraitError,
              name: '_CreateSubRaceStore.racialTraitError'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CreateSubRaceStore.isFormValid'))
          .value;
  Computed<dynamic>? _$createPressedComputed;

  @override
  dynamic get createPressed =>
      (_$createPressedComputed ??= Computed<dynamic>(() => super.createPressed,
              name: '_CreateSubRaceStore.createPressed'))
          .value;

  late final _$_nameAtom =
      Atom(name: '_CreateSubRaceStore._name', context: context);

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
      Atom(name: '_CreateSubRaceStore._description', context: context);

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

  late final _$_parent_raceAtom =
      Atom(name: '_CreateSubRaceStore._parent_race', context: context);

  Race? get parent_race {
    _$_parent_raceAtom.reportRead();
    return super._parent_race;
  }

  @override
  Race? get _parent_race => parent_race;

  @override
  set _parent_race(Race? value) {
    _$_parent_raceAtom.reportWrite(value, super._parent_race, () {
      super._parent_race = value;
    });
  }

  late final _$_selectedRacialTraitsAtom =
      Atom(name: '_CreateSubRaceStore._selectedRacialTraits', context: context);

  ObservableList<RacialTrait> get selectedRacialTraits {
    _$_selectedRacialTraitsAtom.reportRead();
    return super._selectedRacialTraits;
  }

  @override
  ObservableList<RacialTrait> get _selectedRacialTraits => selectedRacialTraits;

  @override
  set _selectedRacialTraits(ObservableList<RacialTrait> value) {
    _$_selectedRacialTraitsAtom.reportWrite(value, super._selectedRacialTraits,
        () {
      super._selectedRacialTraits = value;
    });
  }

  late final _$_listRacialTraitAtom =
      Atom(name: '_CreateSubRaceStore._listRacialTrait', context: context);

  ObservableList<RacialTrait> get listRacialTrait {
    _$_listRacialTraitAtom.reportRead();
    return super._listRacialTrait;
  }

  @override
  ObservableList<RacialTrait> get _listRacialTrait => listRacialTrait;

  @override
  set _listRacialTrait(ObservableList<RacialTrait> value) {
    _$_listRacialTraitAtom.reportWrite(value, super._listRacialTrait, () {
      super._listRacialTrait = value;
    });
  }

  late final _$_savedOrUpdatedOrDeletedAtom = Atom(
      name: '_CreateSubRaceStore._savedOrUpdatedOrDeleted', context: context);

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
      Atom(name: '_CreateSubRaceStore._loading', context: context);

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
      Atom(name: '_CreateSubRaceStore.error', context: context);

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
      Atom(name: '_CreateSubRaceStore.showErrors', context: context);

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

  late final _$_editSubRaceAsyncAction =
      AsyncAction('_CreateSubRaceStore._editSubRace', context: context);

  @override
  Future<void> _editSubRace() {
    return _$_editSubRaceAsyncAction.run(() => super._editSubRace());
  }

  late final _$deleteSubRaceAsyncAction =
      AsyncAction('_CreateSubRaceStore.deleteSubRace', context: context);

  @override
  Future<void> deleteSubRace() {
    return _$deleteSubRaceAsyncAction.run(() => super.deleteSubRace());
  }

  late final _$findRacialTraitsAsyncAction =
      AsyncAction('_CreateSubRaceStore.findRacialTraits', context: context);

  @override
  Future<void> findRacialTraits() {
    return _$findRacialTraitsAsyncAction.run(() => super.findRacialTraits());
  }

  late final _$_CreateSubRaceStoreActionController =
      ActionController(name: '_CreateSubRaceStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setParentRace(Race value) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.setParentRace');
    try {
      return super.setParentRace(value);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRacialTraits(List<RacialTrait> newRacialTraits) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.addRacialTraits');
    try {
      return super.addRacialTraits(newRacialTraits);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeRacialTrait(RacialTrait racialTraitToRemove) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.removeRacialTrait');
    try {
      return super.removeRacialTrait(racialTraitToRemove);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedOrUpdatedOrDeleted(bool value) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.setSavedOrUpdatedOrDeleted');
    try {
      return super.setSavedOrUpdatedOrDeleted(value);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateSubRaceStoreActionController.startAction(
        name: '_CreateSubRaceStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateSubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
showErrors: ${showErrors},
nameValid: ${nameValid},
descriptionValid: ${descriptionValid},
parentRaceValid: ${parentRaceValid},
racialTraitValid: ${racialTraitValid},
racialTraitError: ${racialTraitError},
isFormValid: ${isFormValid},
createPressed: ${createPressed}
    ''';
  }
}
