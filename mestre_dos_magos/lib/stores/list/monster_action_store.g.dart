// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster_action_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MonsterActionStore on _MonsterActionStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_MonsterActionStore.itemCount'))
          .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_MonsterActionStore.showProgress'))
          .value;

  late final _$filterStoreAtom =
      Atom(name: '_MonsterActionStore.filterStore', context: context);

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

  late final _$_listMonsterActionAtom =
      Atom(name: '_MonsterActionStore._listMonsterAction', context: context);

  ObservableList<MonsterAction> get listMonsterAction {
    _$_listMonsterActionAtom.reportRead();
    return super._listMonsterAction;
  }

  @override
  ObservableList<MonsterAction> get _listMonsterAction => listMonsterAction;

  @override
  set _listMonsterAction(ObservableList<MonsterAction> value) {
    _$_listMonsterActionAtom.reportWrite(value, super._listMonsterAction, () {
      super._listMonsterAction = value;
    });
  }

  late final _$_listSearchAtom =
      Atom(name: '_MonsterActionStore._listSearch', context: context);

  ObservableList<MonsterAction> get listSearch {
    _$_listSearchAtom.reportRead();
    return super._listSearch;
  }

  @override
  ObservableList<MonsterAction> get _listSearch => listSearch;

  @override
  set _listSearch(ObservableList<MonsterAction> value) {
    _$_listSearchAtom.reportWrite(value, super._listSearch, () {
      super._listSearch = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_MonsterActionStore._loading', context: context);

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
      Atom(name: '_MonsterActionStore._error', context: context);

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
      Atom(name: '_MonsterActionStore._page', context: context);

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
      Atom(name: '_MonsterActionStore._lastPage', context: context);

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
      AsyncAction('_MonsterActionStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_MonsterActionStore.loadData', context: context);

  @override
  Future<void> loadData(
      {int? page, required FilterSearchStore filterSearchStore}) {
    return _$loadDataAsyncAction.run(
        () => super.loadData(page: page, filterSearchStore: filterSearchStore));
  }

  late final _$_MonsterActionStoreActionController =
      ActionController(name: '_MonsterActionStore', context: context);

  @override
  void setFilter(FilterSearchStore value) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void runFilter(String value) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.runFilter');
    try {
      return super.runFilter(value);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListSearch(List<MonsterAction> newMonsterActions) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.setListSearch');
    try {
      return super.setListSearch(newMonsterActions);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewMonsterActions(List<MonsterAction> newMonsterActions) {
    final _$actionInfo = _$_MonsterActionStoreActionController.startAction(
        name: '_MonsterActionStore.addNewMonsterActions');
    try {
      return super.addNewMonsterActions(newMonsterActions);
    } finally {
      _$_MonsterActionStoreActionController.endAction(_$actionInfo);
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
