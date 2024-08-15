import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/player.dart';
import '../../repositories/player_repository.dart';
import '../filter_search_store.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'player_store.g.dart';

class PlayerStore = _PlayerStore with _$PlayerStore;

abstract class _PlayerStore with Store {
  _PlayerStore() {
    refreshData();

    autorun((_) async {
      await loadData(page: _page, filterSearchStore: filterStore);
    });
  }

  //monitora qual é o filtro atual
  @observable
  FilterSearchStore filterStore = FilterSearchStore();

  //retorna uma copia do FilterStore atual ou seja uma copia do filtro atual quando abrir a tela para editar o filtro
  FilterSearchStore get getCloneFilterStore => filterStore.cloneFilter();

  @action
  void setFilter(FilterSearchStore value) {
    filterStore = value;
    setPage(0);
    resetPage();
  }

  @readonly
  ObservableList<Player> _listPlayer = ObservableList();


  @readonly
  ObservableList<Player> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<Player> result = [];

    if(value.isEmpty){
      result = _listPlayer;
    }else{
      result = _listPlayer.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<Player> newPlayers){
    _listSearch.addAll(newPlayers);
  }

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
    _lastPage = false;
  }

  @action
  void addNewPlayers(List<Player> newPlayers) {
    if (newPlayers.length < 15) _lastPage = true;
    _listPlayer.addAll(newPlayers);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listPlayer.clear();

    try {
      final result = await PlayerRepository().getAllPlayers(page: page, filterSearchStore: filterSearchStore);
      addNewPlayers(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Jogadores!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Jogadores');
    }

    setLoading(false);
  }
}