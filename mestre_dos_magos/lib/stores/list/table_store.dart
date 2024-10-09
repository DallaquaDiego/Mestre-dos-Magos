import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'table_store.g.dart';

class TableStore = _TableStore with _$TableStore;

abstract class _TableStore with Store {
  @readonly
  bool _loading = false;

  @action
  void setLoading(bool value) => _loading = value;

  @readonly
  String? _error;

  @action
  void setError(String? value) => _error = value;

  //PAGINAÇÃO
  @readonly
  int _page = 1;

  @action
  void setPage(int value) => _page = value;

  @computed
  bool get showProgress => _loading;

  @action
  Future<void> refreshData() async {
    setPage(0);
    resetPage();
  }

  void resetPage() {
    _page = 1;
  }
}