import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/monster.dart';
import '../../models/player.dart';
import '../../repositories/monster_repository.dart';
import '../../repositories/player_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'table_store.g.dart';

class TableStore = _TableStore with _$TableStore;

abstract class _TableStore with Store {
  _TableStore() {
    refreshData();

    autorun((_) async {
      await loadData(page: _page);
    });
  }

  @readonly
  ObservableList<Player> _listPlayer = ObservableList();

  @readonly
  ObservableList<Monster> _listMonster = ObservableList();

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

  @readonly
  bool _lastPage = false;

  @action
  void setLastPage(bool value) => _lastPage = value;

  @computed
  int get itemCount => _lastPage ? _listPlayer.length : _listPlayer.length + 1;

  @computed
  bool get showProgress => _loading && _listPlayer.isEmpty;

  @action
  void loadNextPage() {
    _page++;
  }

  @action
  Future<void> refreshData() async {
    setPage(0);
    resetPage();
  }

  void resetPage() {
    _page = 1;
    _listPlayer.clear();
    _listMonster.clear();
    _lastPage = false;
  }

  @action
  void addNewPlayers(List<Player> newPlayers) {
    if (newPlayers.length < 15) _lastPage = true;
    _listPlayer.addAll(newPlayers);
  }

  @action
  void addNewMonsters(List<Monster> newMonsters) {
    if (newMonsters.length < 15) _lastPage = true;
    _listMonster.addAll(newMonsters);
  }

  @action
  Future<void> loadData({int? page}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listPlayer.clear();

    try {
      final resultP = await PlayerRepository().getAllPlayers(page: page);
      final resultM = await MonsterRepository().getAllMonsters(page: page);
      addNewPlayers(resultP);
      addNewMonsters(resultM);
    } catch (e, s) {
      log('Store: Erro ao Carregar Jogadores e Monstros!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Jogadores e Monstros');
    }

    setLoading(false);
  }
}