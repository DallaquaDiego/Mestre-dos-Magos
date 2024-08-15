import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/monster.dart';
import '../../repositories/monster_repository.dart';
import '../filter_search_store.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'monster_store.g.dart';

class MonsterStore = _MonsterStore with _$MonsterStore;

abstract class _MonsterStore with Store {
  _MonsterStore() {
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
  ObservableList<Monster> _listMonster = ObservableList();


  @readonly
  ObservableList<Monster> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<Monster> result = [];

    if(value.isEmpty){
      result = _listMonster;
    }else{
      result = _listMonster.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<Monster> newMonsters){
    _listSearch.addAll(newMonsters);
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
  int get itemCount => _lastPage ? _listMonster.length : _listMonster.length + 1;

  @computed
  bool get showProgress => _loading && _listMonster.isEmpty;

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
    _listMonster.clear();
    _lastPage = false;
  }

  @action
  void addNewMonsters(List<Monster> newMonsters) {
    if (newMonsters.length < 15) _lastPage = true;
    _listMonster.addAll(newMonsters);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listMonster.clear();

    try {
      final result = await MonsterRepository().getAllMonsters(page: page, filterSearchStore: filterSearchStore);
      addNewMonsters(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Monstros!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Monstros');
    }

    setLoading(false);
  }
}