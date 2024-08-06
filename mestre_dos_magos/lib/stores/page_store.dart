import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'page_store.g.dart';

class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {
  @readonly
  int _page = 0;

  @action
  void setPage(int value) => _page = value;

  // Ativa o bloqueio da paginação ou não
  @readonly
  bool _acttiveBlockPagination = true;

  @action
  void setActtiveBlockPagination(bool value) => _acttiveBlockPagination = value;

  // Bloqueia a paginação ou não
  @readonly
  bool _blockPagination = false;

  @action
  void setBlockPagination(bool value) {
    if (_acttiveBlockPagination) {
      _blockPagination = value;
    } else {
      _blockPagination = false;
    }
  }
}
