import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/monster_action.dart';
import '../../repositories/monster_action_repository.dart';
import '../filter_search_store.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'monster_action_store.g.dart';

class MonsterActionStore = _MonsterActionStore with _$MonsterActionStore;

abstract class _MonsterActionStore with Store {
  _MonsterActionStore() {
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
  ObservableList<MonsterAction> _listMonsterAction = ObservableList();


  @readonly
  ObservableList<MonsterAction> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<MonsterAction> result = [];

    if(value.isEmpty){
      result = _listMonsterAction;
    }else{
      result = _listMonsterAction.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<MonsterAction> newMonsterActions){
    _listSearch.addAll(newMonsterActions);
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
  int get itemCount => _lastPage ? _listMonsterAction.length : _listMonsterAction.length + 1;

  @computed
  bool get showProgress => _loading && _listMonsterAction.isEmpty;

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
    _listMonsterAction.clear();
    _lastPage = false;
  }

  @action
  void addNewMonsterActions(List<MonsterAction> newMonsterActions) {
    if (newMonsterActions.length < 15) _lastPage = true;
    _listMonsterAction.addAll(newMonsterActions);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listMonsterAction.clear();

    try {
      final result = await MonsterActionRepository().getAllActions(page: page, filterSearchStore: filterSearchStore);
      addNewMonsterActions(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Ações dos Monstros!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Ações dos Monstros');
    }

    setLoading(false);
  }
}