// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClassStore on _ClassStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount => (_$itemCountComputed ??=
          Computed<int>(() => super.itemCount, name: '_ClassStore.itemCount'))
      .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_ClassStore.showProgress'))
          .value;

  late final _$filterStoreAtom =
      Atom(name: '_ClassStore.filterStore', context: context);

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

  late final _$_listClassAtom =
      Atom(name: '_ClassStore._listClass', context: context);

  ObservableList<Class> get listClass {
    _$_listClassAtom.reportRead();
    return super._listClass;
  }

  @override
  ObservableList<Class> get _listClass => listClass;

  @override
  set _listClass(ObservableList<Class> value) {
    _$_listClassAtom.reportWrite(value, super._listClass, () {
      super._listClass = value;
    });
  }

  late final _$_listSearchAtom =
      Atom(name: '_ClassStore._listSearch', context: context);

  ObservableList<Class> get listSearch {
    _$_listSearchAtom.reportRead();
    return super._listSearch;
  }

  @override
  ObservableList<Class> get _listSearch => listSearch;

  @override
  set _listSearch(ObservableList<Class> value) {
    _$_listSearchAtom.reportWrite(value, super._listSearch, () {
      super._listSearch = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_ClassStore._loading', context: context);

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

  late final _$_errorAtom = Atom(name: '_ClassStore._error', context: context);

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

  late final _$_pageAtom = Atom(name: '_ClassStore._page', context: context);

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
      Atom(name: '_ClassStore._lastPage', context: context);

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
      AsyncAction('_ClassStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_ClassStore.loadData', context: context);

  @override
  Future<void> loadData(
      {int? page, required FilterSearchStore filterSearchStore}) {
    return _$loadDataAsyncAction.run(
        () => super.loadData(page: page, filterSearchStore: filterSearchStore));
  }

  late final _$_ClassStoreActionController =
      ActionController(name: '_ClassStore', context: context);

  @override
  void setFilter(FilterSearchStore value) {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void runFilter(String value) {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.runFilter');
    try {
      return super.runFilter(value);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListSearch(List<Class> newItems) {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.setListSearch');
    try {
      return super.setListSearch(newItems);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo =
        _$_ClassStoreActionController.startAction(name: '_ClassStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo =
        _$_ClassStoreActionController.startAction(name: '_ClassStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewItems(List<Class> newItems) {
    final _$actionInfo = _$_ClassStoreActionController.startAction(
        name: '_ClassStore.addNewItems');
    try {
      return super.addNewItems(newItems);
    } finally {
      _$_ClassStoreActionController.endAction(_$actionInfo);
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
