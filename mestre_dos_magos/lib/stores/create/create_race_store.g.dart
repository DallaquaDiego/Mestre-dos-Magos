// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_race_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateRaceStore on _CreateRaceStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateRaceStore.nameValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateRaceStore.descriptionValid'))
      .value;
  Computed<bool>? _$racialTraitValidComputed;

  @override
  bool get racialTraitValid => (_$racialTraitValidComputed ??= Computed<bool>(
          () => super.racialTraitValid,
          name: '_CreateRaceStore.racialTraitValid'))
      .value;
  Computed<String?>? _$racialTraitErrorComputed;

  @override
  String? get racialTraitError => (_$racialTraitErrorComputed ??=
          Computed<String?>(() => super.racialTraitError,
              name: '_CreateRaceStore.racialTraitError'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CreateRaceStore.isFormValid'))
          .value;
  Computed<dynamic>? _$createPressedComputed;

  @override
  dynamic get createPressed =>
      (_$createPressedComputed ??= Computed<dynamic>(() => super.createPressed,
              name: '_CreateRaceStore.createPressed'))
          .value;

  late final _$_nameAtom =
      Atom(name: '_CreateRaceStore._name', context: context);

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
      Atom(name: '_CreateRaceStore._description', context: context);

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

  late final _$_selectedRacialTraitsAtom =
      Atom(name: '_CreateRaceStore._selectedRacialTraits', context: context);

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
      Atom(name: '_CreateRaceStore._listRacialTrait', context: context);

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

  late final _$_savedOrUpdatedOrDeletedAtom =
      Atom(name: '_CreateRaceStore._savedOrUpdatedOrDeleted', context: context);

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
      Atom(name: '_CreateRaceStore._loading', context: context);

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
      Atom(name: '_CreateRaceStore.error', context: context);

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
      Atom(name: '_CreateRaceStore.showErrors', context: context);

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

  late final _$_editRaceAsyncAction =
      AsyncAction('_CreateRaceStore._editRace', context: context);

  @override
  Future<void> _editRace() {
    return _$_editRaceAsyncAction.run(() => super._editRace());
  }

  late final _$deleteRaceAsyncAction =
      AsyncAction('_CreateRaceStore.deleteRace', context: context);

  @override
  Future<void> deleteRace() {
    return _$deleteRaceAsyncAction.run(() => super.deleteRace());
  }

  late final _$findRacialTraitsAsyncAction =
      AsyncAction('_CreateRaceStore.findRacialTraits', context: context);

  @override
  Future<void> findRacialTraits() {
    return _$findRacialTraitsAsyncAction.run(() => super.findRacialTraits());
  }

  late final _$_CreateRaceStoreActionController =
      ActionController(name: '_CreateRaceStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRacialTraits(List<RacialTrait> newRacialTraits) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.addRacialTraits');
    try {
      return super.addRacialTraits(newRacialTraits);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeRacialTrait(RacialTrait racialTraitToRemove) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.removeRacialTrait');
    try {
      return super.removeRacialTrait(racialTraitToRemove);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedOrUpdatedOrDeleted(bool value) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.setSavedOrUpdatedOrDeleted');
    try {
      return super.setSavedOrUpdatedOrDeleted(value);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateRaceStoreActionController.startAction(
        name: '_CreateRaceStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
showErrors: ${showErrors},
nameValid: ${nameValid},
descriptionValid: ${descriptionValid},
racialTraitValid: ${racialTraitValid},
racialTraitError: ${racialTraitError},
isFormValid: ${isFormValid},
createPressed: ${createPressed}
    ''';
  }
}
