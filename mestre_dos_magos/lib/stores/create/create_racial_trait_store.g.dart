// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_racial_trait_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateRacialTraitStore on _CreateRacialTraitStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateRacialTraitStore.nameValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateRacialTraitStore.descriptionValid'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CreateRacialTraitStore.isFormValid'))
          .value;
  Computed<dynamic>? _$createPressedComputed;

  @override
  dynamic get createPressed =>
      (_$createPressedComputed ??= Computed<dynamic>(() => super.createPressed,
              name: '_CreateRacialTraitStore.createPressed'))
          .value;

  late final _$_nameAtom =
      Atom(name: '_CreateRacialTraitStore._name', context: context);

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
      Atom(name: '_CreateRacialTraitStore._description', context: context);

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

  late final _$_savedOrUpdatedOrDeletedAtom = Atom(
      name: '_CreateRacialTraitStore._savedOrUpdatedOrDeleted',
      context: context);

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
      Atom(name: '_CreateRacialTraitStore._loading', context: context);

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
      Atom(name: '_CreateRacialTraitStore.error', context: context);

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
      Atom(name: '_CreateRacialTraitStore.showErrors', context: context);

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

  late final _$_editRacialTraitAsyncAction =
      AsyncAction('_CreateRacialTraitStore._editRacialTrait', context: context);

  @override
  Future<void> _editRacialTrait() {
    return _$_editRacialTraitAsyncAction.run(() => super._editRacialTrait());
  }

  late final _$deleteRacialTraitAsyncAction = AsyncAction(
      '_CreateRacialTraitStore.deleteRacialTrait',
      context: context);

  @override
  Future<void> deleteRacialTrait() {
    return _$deleteRacialTraitAsyncAction.run(() => super.deleteRacialTrait());
  }

  late final _$_CreateRacialTraitStoreActionController =
      ActionController(name: '_CreateRacialTraitStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateRacialTraitStoreActionController.startAction(
        name: '_CreateRacialTraitStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateRacialTraitStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateRacialTraitStoreActionController.startAction(
        name: '_CreateRacialTraitStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateRacialTraitStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedOrUpdatedOrDeleted(bool value) {
    final _$actionInfo = _$_CreateRacialTraitStoreActionController.startAction(
        name: '_CreateRacialTraitStore.setSavedOrUpdatedOrDeleted');
    try {
      return super.setSavedOrUpdatedOrDeleted(value);
    } finally {
      _$_CreateRacialTraitStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateRacialTraitStoreActionController.startAction(
        name: '_CreateRacialTraitStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateRacialTraitStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_CreateRacialTraitStoreActionController.startAction(
        name: '_CreateRacialTraitStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CreateRacialTraitStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateRacialTraitStoreActionController.startAction(
        name: '_CreateRacialTraitStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateRacialTraitStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
showErrors: ${showErrors},
nameValid: ${nameValid},
descriptionValid: ${descriptionValid},
isFormValid: ${isFormValid},
createPressed: ${createPressed}
    ''';
  }
}
