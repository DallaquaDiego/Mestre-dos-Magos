// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TableStore on _TableStore, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount => (_$itemCountComputed ??=
          Computed<int>(() => super.itemCount, name: '_TableStore.itemCount'))
      .value;
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_TableStore.showProgress'))
          .value;

  late final _$_listPlayerAtom =
      Atom(name: '_TableStore._listPlayer', context: context);

  ObservableList<Player> get listPlayer {
    _$_listPlayerAtom.reportRead();
    return super._listPlayer;
  }

  @override
  ObservableList<Player> get _listPlayer => listPlayer;

  @override
  set _listPlayer(ObservableList<Player> value) {
    _$_listPlayerAtom.reportWrite(value, super._listPlayer, () {
      super._listPlayer = value;
    });
  }

  late final _$_listMonsterAtom =
      Atom(name: '_TableStore._listMonster', context: context);

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

  late final _$_loadingAtom =
      Atom(name: '_TableStore._loading', context: context);

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

  late final _$_errorAtom = Atom(name: '_TableStore._error', context: context);

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

  late final _$_pageAtom = Atom(name: '_TableStore._page', context: context);

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
      Atom(name: '_TableStore._lastPage', context: context);

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
      AsyncAction('_TableStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
  }

  late final _$loadDataAsyncAction =
      AsyncAction('_TableStore.loadData', context: context);

  @override
  Future<void> loadData({int? page}) {
    return _$loadDataAsyncAction.run(() => super.loadData(page: page));
  }

  late final _$_TableStoreActionController =
      ActionController(name: '_TableStore', context: context);

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_TableStoreActionController.startAction(
        name: '_TableStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo =
        _$_TableStoreActionController.startAction(name: '_TableStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int value) {
    final _$actionInfo =
        _$_TableStoreActionController.startAction(name: '_TableStore.setPage');
    try {
      return super.setPage(value);
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastPage(bool value) {
    final _$actionInfo = _$_TableStoreActionController.startAction(
        name: '_TableStore.setLastPage');
    try {
      return super.setLastPage(value);
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_TableStoreActionController.startAction(
        name: '_TableStore.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewPlayers(List<Player> newPlayers) {
    final _$actionInfo = _$_TableStoreActionController.startAction(
        name: '_TableStore.addNewPlayers');
    try {
      return super.addNewPlayers(newPlayers);
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewMonsters(List<Monster> newMonsters) {
    final _$actionInfo = _$_TableStoreActionController.startAction(
        name: '_TableStore.addNewMonsters');
    try {
      return super.addNewMonsters(newMonsters);
    } finally {
      _$_TableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemCount: ${itemCount},
showProgress: ${showProgress}
    ''';
  }
}
