// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ItemCategoryStore on _ItemCategoryStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_ItemCategoryStore.itemCount'))
          .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_ItemCategoryStore.showProgress'))
          .value;

  late final _$filterStoreAtom =
      Atom(name: '_ItemCategoryStore.filterStore', context: context);

  @override
  FilterSearchStore get filterStore {
    _$filterStoreAtom.reportRead();
    return super.filterStore;
  }

  @override
  set filterStore(FilterSearchStore value) {
    _$filterStoreAtom.reportWrite(value, super.filterStore, () {
      super.filterStore = value;
    });
  }

  late final _$_listItemCategoryAtom =
      Atom(name: '_ItemCategoryStore._listItemCategory', context: context);

  ObservableList<ItemCategory> get listItemCategory {
    _$_listItemCategoryAtom.reportRead();
    return super._listItemCategory;
  }

  @override
  ObservableList<ItemCategory> get _listItemCategory => listItemCategory;

  @override
  set _listItemCategory(ObservableList<ItemCategory> value) {
    _$_listItemCategoryAtom.reportWrite(value, super._listItemCategory, () {
      super._listItemCategory = value;
    });
  }

  late final _$_listSearchAtom =
      Atom(name: '_ItemCategoryStore._listSearch', context: context);

  ObservableList<ItemCategory> get listSearch {
    _$_listSearchAtom.reportRead();
    return super._listSearch;
  }

  @override
  ObservableList<ItemCategory> get _listSearch => listSearch;

  @override
  set _listSearch(ObservableList<ItemCategory> value) {
    _$_listSearchAtom.reportWrite(value, super._listSearch, () {
      super._listSearch = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_ItemCategoryStore._loading', context: context);

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

  late final _$_errorAtom =
      Atom(name: '_ItemCategoryStore._error', context: context);

  String? get error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  String? get _error => error;

  @override
  set _error(String? value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  late final _$_pageAtom =
      Atom(name: '_ItemCategoryStore._page', context: context);

  int get page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  int get _page => page;

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  late final _$_lastPageAtom =
      Atom(name: '_ItemCategoryStore._lastPage', context: context);

  bool get lastPage {
    _$_lastPageAtom.reportRead();
    return super._lastPage;
  }

  @override
  bool get _lastPage => lastPage;

  @override
  set _lastPage(bool value) {
    _$_lastPageAtom.reportWrite(value, super._lastPage, () {
      super._lastPage = value;
    });
  }

  late final _$refreshDataAsyncAction =
      AsyncAction('_ItemCategoryStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_ItemCategoryStore.loadData', context: context);

  @override
  Future<void> loadData(
      {int? page, required FilterSearchStore filterSearchStore}) {
    return _$loadDataAsyncAction.run(
        () => super.loadData(page: page, filterSearchStore: filterSearchStore));
  }

  late final _$_ItemCategoryStoreActionController =
      ActionController(name: '_ItemCategoryStore', context: context);

  @override
  void setFilter(FilterSearchStore value) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void runFilter(String value) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.runFilter');
    try {
      return super.runFilter(value);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListSearch(List<ItemCategory> newItems) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.setListSearch');
    try {
      return super.setListSearch(newItems);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewItems(List<ItemCategory> newItems) {
    final _$actionInfo = _$_ItemCategoryStoreActionController.startAction(
        name: '_ItemCategoryStore.addNewItems');
    try {
      return super.addNewItems(newItems);
    } finally {
      _$_ItemCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filterStore: ${filterStore},
itemCount: ${itemCount},
showProgress: ${showProgress}
    ''';
  }
}
