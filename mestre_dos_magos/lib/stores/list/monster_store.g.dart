// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MonsterStore on _MonsterStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount => (_$itemCountComputed ??=
          Computed<int>(() => super.itemCount, name: '_MonsterStore.itemCount'))
      .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_MonsterStore.showProgress'))
          .value;

  late final _$filterStoreAtom =
      Atom(name: '_MonsterStore.filterStore', context: context);

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

  late final _$_listMonsterAtom =
      Atom(name: '_MonsterStore._listMonster', context: context);

  ObservableList<Monster> get listMonster {
    _$_listMonsterAtom.reportRead();
    return super._listMonster;
  }

  @override
  ObservableList<Monster> get _listMonster => listMonster;

  @override
  set _listMonster(ObservableList<Monster> value) {
    _$_listMonsterAtom.reportWrite(value, super._listMonster, () {
      super._listMonster = value;
    });
  }

  late final _$_listSearchAtom =
      Atom(name: '_MonsterStore._listSearch', context: context);

  ObservableList<Monster> get listSearch {
    _$_listSearchAtom.reportRead();
    return super._listSearch;
  }

  @override
  ObservableList<Monster> get _listSearch => listSearch;

  @override
  set _listSearch(ObservableList<Monster> value) {
    _$_listSearchAtom.reportWrite(value, super._listSearch, () {
      super._listSearch = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_MonsterStore._loading', context: context);

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
      Atom(name: '_MonsterStore._error', context: context);

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

  late final _$_pageAtom = Atom(name: '_MonsterStore._page', context: context);

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
      Atom(name: '_MonsterStore._lastPage', context: context);

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
      AsyncAction('_MonsterStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_MonsterStore.loadData', context: context);

  @override
  Future<void> loadData(
      {int? page, required FilterSearchStore filterSearchStore}) {
    return _$loadDataAsyncAction.run(
        () => super.loadData(page: page, filterSearchStore: filterSearchStore));
  }

  late final _$_MonsterStoreActionController =
      ActionController(name: '_MonsterStore', context: context);

  @override
  void setFilter(FilterSearchStore value) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void runFilter(String value) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.runFilter');
    try {
      return super.runFilter(value);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListSearch(List<Monster> newMonsters) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.setListSearch');
    try {
      return super.setListSearch(newMonsters);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewMonsters(List<Monster> newMonsters) {
    final _$actionInfo = _$_MonsterStoreActionController.startAction(
        name: '_MonsterStore.addNewMonsters');
    try {
      return super.addNewMonsters(newMonsters);
    } finally {
      _$_MonsterStoreActionController.endAction(_$actionInfo);
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
