// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateItemStore on _CreateItemStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateItemStore.nameValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateItemStore.descriptionValid'))
      .value;
  Computed<bool>? _$priceValidComputed;

  @override
  bool get priceValid =>
      (_$priceValidComputed ??= Computed<bool>(() => super.priceValid,
              name: '_CreateItemStore.priceValid'))
          .value;
  Computed<bool>? _$itemCategoryValidComputed;

  @override
  bool get itemCategoryValid => (_$itemCategoryValidComputed ??= Computed<bool>(
          () => super.itemCategoryValid,
          name: '_CreateItemStore.itemCategoryValid'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CreateItemStore.isFormValid'))
          .value;
  Computed<dynamic>? _$createPressedComputed;

  @override
  dynamic get createPressed =>
      (_$createPressedComputed ??= Computed<dynamic>(() => super.createPressed,
              name: '_CreateItemStore.createPressed'))
          .value;

  late final _$_nameAtom =
      Atom(name: '_CreateItemStore._name', context: context);

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
      Atom(name: '_CreateItemStore._description', context: context);

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

  late final _$_priceAtom =
      Atom(name: '_CreateItemStore._price', context: context);

  String get price {
    _$_priceAtom.reportRead();
    return super._price;
  }

  @override
  String get _price => price;

  @override
  set _price(String value) {
    _$_priceAtom.reportWrite(value, super._price, () {
      super._price = value;
    });
  }

  late final _$_damageAtom =
      Atom(name: '_CreateItemStore._damage', context: context);

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

  late final _$_effectAtom =
      Atom(name: '_CreateItemStore._effect', context: context);

  String get effect {
    _$_effectAtom.reportRead();
    return super._effect;
  }

  @override
  String get _effect => effect;

  @override
  set _effect(String value) {
    _$_effectAtom.reportWrite(value, super._effect, () {
      super._effect = value;
    });
  }

  late final _$_item_categoryAtom =
      Atom(name: '_CreateItemStore._item_category', context: context);

  ItemCategory? get item_category {
    _$_item_categoryAtom.reportRead();
    return super._item_category;
  }

  @override
  ItemCategory? get _item_category => item_category;

  @override
  set _item_category(ItemCategory? value) {
    _$_item_categoryAtom.reportWrite(value, super._item_category, () {
      super._item_category = value;
    });
  }

  late final _$_savedOrUpdatedOrDeletedAtom =
      Atom(name: '_CreateItemStore._savedOrUpdatedOrDeleted', context: context);

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
      Atom(name: '_CreateItemStore._loading', context: context);

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
      Atom(name: '_CreateItemStore.error', context: context);

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
      Atom(name: '_CreateItemStore.showErrors', context: context);

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

  late final _$_editItemAsyncAction =
      AsyncAction('_CreateItemStore._editItem', context: context);

  @override
  Future<void> _editItem() {
    return _$_editItemAsyncAction.run(() => super._editItem());
  }

  late final _$deleteItemAsyncAction =
      AsyncAction('_CreateItemStore.deleteItem', context: context);

  @override
  Future<void> deleteItem() {
    return _$deleteItemAsyncAction.run(() => super.deleteItem());
  }

  late final _$_CreateItemStoreActionController =
      ActionController(name: '_CreateItemStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrice(String value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setPrice');
    try {
      return super.setPrice(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDamage(String value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setDamage');
    try {
      return super.setDamage(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEffect(String value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setEffect');
    try {
      return super.setEffect(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setItemCategory(ItemCategory value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setItemCategory');
    try {
      return super.setItemCategory(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSavedOrUpdatedOrDeleted(bool value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setSavedOrUpdatedOrDeleted');
    try {
      return super.setSavedOrUpdatedOrDeleted(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateItemStoreActionController.startAction(
        name: '_CreateItemStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
showErrors: ${showErrors},
nameValid: ${nameValid},
descriptionValid: ${descriptionValid},
priceValid: ${priceValid},
itemCategoryValid: ${itemCategoryValid},
isFormValid: ${isFormValid},
createPressed: ${createPressed}
    ''';
  }
}
