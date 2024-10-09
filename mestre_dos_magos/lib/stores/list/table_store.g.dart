// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TableStore on _TableStore, Store {
  Computed<bool>? _$showProgressComputed;

  @override
  bool get showProgress =>
      (_$showProgressComputed ??= Computed<bool>(() => super.showProgress,
              name: '_TableStore.showProgress'))
          .value;

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

  late final _$refreshDataAsyncAction =
      AsyncAction('_TableStore.refreshData', context: context);

  @override
  Future<void> refreshData() {
    return _$refreshDataAsyncAction.run(() => super.refreshData());
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
  String toString() {
    return '''
showProgress: ${showProgress}
    ''';
  }
}
