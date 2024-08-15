// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_item_category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateItemCategoryStore on _CreateItemCategoryStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateItemCategoryStore.nameValid'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CreateItemCategoryStore.isFormValid'))
          .value;
  Computed<dynamic>? _$createPressedComputed;

  @override
  dynamic get createPressed =>
      (_$createPressedComputed ??= Computed<dynamic>(() => super.createPressed,
              name: '_CreateItemCategoryStore.createPressed'))
          .value;

  late final _$_nameAtom =
      Atom(name: '_CreateItemCategoryStore._name', context: context);

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

  late final _$_savedOrUpdatedOrDeletedAtom = Atom(
      name: '_CreateItemCategoryStore._savedOrUpdatedOrDeleted',
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
      Atom(name: '_CreateItemCategoryStore._loading', context: context);

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
      Atom(name: '_CreateItemCategoryStore.error', context: context);

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
      Atom(name: '_CreateItemCategoryStore.showErrors', context: context);

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

  late final _$_editItemCategoryAsyncAction = AsyncAction(
      '_CreateItemCategoryStore._editItemCategory',
      context: context);

  @override
  Future<void> _editItemCategory() {
    return _$_editItemCategoryAsyncAction.run(() => super._editItemCategory());
  }

  late final _$deleteItemCategoryAsyncAction = AsyncAction(
      '_CreateItemCategoryStore.deleteItemCategory',
      context: context);

  @override
  Future<void> deleteItemCategory() {
    return _$deleteItemCategoryAsyncAction
        .run(() => super.deleteItemCategory());
  }

  late final _$_CreateItemCategoryStoreActionController =
      ActionController(name: '_CreateItemCategoryStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateItemCategoryStoreActionController.startAction(
        name: '_CreateItemCategoryStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedOrUpdatedOrDeleted(bool value) {
    final _$actionInfo = _$_CreateItemCategoryStoreActionController.startAction(
        name: '_CreateItemCategoryStore.setSavedOrUpdatedOrDeleted');
    try {
      return super.setSavedOrUpdatedOrDeleted(value);
    } finally {
      _$_CreateItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateItemCategoryStoreActionController.startAction(
        name: '_CreateItemCategoryStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_CreateItemCategoryStoreActionController.startAction(
        name: '_CreateItemCategoryStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CreateItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateItemCategoryStoreActionController.startAction(
        name: '_CreateItemCategoryStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
showErrors: ${showErrors},
nameValid: ${nameValid},
isFormValid: ${isFormValid},
createPressed: ${createPressed}
    ''';
  }
}
