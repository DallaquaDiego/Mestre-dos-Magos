// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_race_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SubRaceStore on _SubRaceStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount => (_$itemCountComputed ??=
          Computed<int>(() => super.itemCount, name: '_SubRaceStore.itemCount'))
      .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_SubRaceStore.showProgress'))
          .value;

  late final _$filterStoreAtom =
      Atom(name: '_SubRaceStore.filterStore', context: context);

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

  late final _$_listSubRaceAtom =
      Atom(name: '_SubRaceStore._listSubRace', context: context);

  ObservableList<SubRace> get listSubRace {
    _$_listSubRaceAtom.reportRead();
    return super._listSubRace;
  }

  @override
  ObservableList<SubRace> get _listSubRace => listSubRace;

  @override
  set _listSubRace(ObservableList<SubRace> value) {
    _$_listSubRaceAtom.reportWrite(value, super._listSubRace, () {
      super._listSubRace = value;
    });
  }

  late final _$_listSearchAtom =
      Atom(name: '_SubRaceStore._listSearch', context: context);

  ObservableList<SubRace> get listSearch {
    _$_listSearchAtom.reportRead();
    return super._listSearch;
  }

  @override
  ObservableList<SubRace> get _listSearch => listSearch;

  @override
  set _listSearch(ObservableList<SubRace> value) {
    _$_listSearchAtom.reportWrite(value, super._listSearch, () {
      super._listSearch = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_SubRaceStore._loading', context: context);

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
      Atom(name: '_SubRaceStore._error', context: context);

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

  late final _$_pageAtom = Atom(name: '_SubRaceStore._page', context: context);

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
      Atom(name: '_SubRaceStore._lastPage', context: context);

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
      AsyncAction('_SubRaceStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_SubRaceStore.loadData', context: context);

  @override
  Future<void> loadData(
      {int? page, required FilterSearchStore filterSearchStore}) {
    return _$loadDataAsyncAction.run(
        () => super.loadData(page: page, filterSearchStore: filterSearchStore));
  }

  late final _$_SubRaceStoreActionController =
      ActionController(name: '_SubRaceStore', context: context);

  @override
  void setFilter(FilterSearchStore value) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void runFilter(String value) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.runFilter');
    try {
      return super.runFilter(value);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListSearch(List<SubRace> newSubRaces) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.setListSearch');
    try {
      return super.setListSearch(newSubRaces);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewSubRaces(List<SubRace> newSubRaces) {
    final _$actionInfo = _$_SubRaceStoreActionController.startAction(
        name: '_SubRaceStore.addNewSubRaces');
    try {
      return super.addNewSubRaces(newSubRaces);
    } finally {
      _$_SubRaceStoreActionController.endAction(_$actionInfo);
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
