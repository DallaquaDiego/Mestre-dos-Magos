// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RaceStore on _RaceStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount => (_$itemCountComputed ??=
          Computed<int>(() => super.itemCount, name: '_RaceStore.itemCount'))
      .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_RaceStore.showProgress'))
          .value;

  late final _$filterStoreAtom =
      Atom(name: '_RaceStore.filterStore', context: context);

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

  late final _$_listRaceAtom =
      Atom(name: '_RaceStore._listRace', context: context);

  ObservableList<Race> get listRace {
    _$_listRaceAtom.reportRead();
    return super._listRace;
  }

  @override
  ObservableList<Race> get _listRace => listRace;

  @override
  set _listRace(ObservableList<Race> value) {
    _$_listRaceAtom.reportWrite(value, super._listRace, () {
      super._listRace = value;
    });
  }

  late final _$_listSearchAtom =
      Atom(name: '_RaceStore._listSearch', context: context);

  ObservableList<Race> get listSearch {
    _$_listSearchAtom.reportRead();
    return super._listSearch;
  }

  @override
  ObservableList<Race> get _listSearch => listSearch;

  @override
  set _listSearch(ObservableList<Race> value) {
    _$_listSearchAtom.reportWrite(value, super._listSearch, () {
      super._listSearch = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_RaceStore._loading', context: context);

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

  late final _$_errorAtom = Atom(name: '_RaceStore._error', context: context);

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

  late final _$_pageAtom = Atom(name: '_RaceStore._page', context: context);

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
      Atom(name: '_RaceStore._lastPage', context: context);

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
      AsyncAction('_RaceStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_RaceStore.loadData', context: context);

  @override
  Future<void> loadData(
      {int? page, required FilterSearchStore filterSearchStore}) {
    return _$loadDataAsyncAction.run(
        () => super.loadData(page: page, filterSearchStore: filterSearchStore));
  }

  late final _$_RaceStoreActionController =
      ActionController(name: '_RaceStore', context: context);

  @override
  void setFilter(FilterSearchStore value) {
    final _$actionInfo =
        _$_RaceStoreActionController.startAction(name: '_RaceStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void runFilter(String value) {
    final _$actionInfo =
        _$_RaceStoreActionController.startAction(name: '_RaceStore.runFilter');
    try {
      return super.runFilter(value);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListSearch(List<Race> newRaces) {
    final _$actionInfo = _$_RaceStoreActionController.startAction(
        name: '_RaceStore.setListSearch');
    try {
      return super.setListSearch(newRaces);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo =
        _$_RaceStoreActionController.startAction(name: '_RaceStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo =
        _$_RaceStoreActionController.startAction(name: '_RaceStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo =
        _$_RaceStoreActionController.startAction(name: '_RaceStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_RaceStoreActionController.startAction(
        name: '_RaceStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_RaceStoreActionController.startAction(
        name: '_RaceStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewRaces(List<Race> newRaces) {
    final _$actionInfo = _$_RaceStoreActionController.startAction(
        name: '_RaceStore.addNewRaces');
    try {
      return super.addNewRaces(newRaces);
    } finally {
      _$_RaceStoreActionController.endAction(_$actionInfo);
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
