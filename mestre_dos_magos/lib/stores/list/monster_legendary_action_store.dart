import 'dart:developer';
import 'package:mobx/mobx.dart';

import '../../models/monster_legendary_action.dart';
import '../../repositories/monster_legendary_action_repository.dart';
import '../filter_search_store.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'monster_legendary_action_store.g.dart';

class MonsterLegendaryActionStore = _MonsterLegendaryActionStore with _$MonsterLegendaryActionStore;

abstract class _MonsterLegendaryActionStore with Store {
  _MonsterLegendaryActionStore() {
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
  ObservableList<MonsterLegendaryAction> _listMonsterLegendaryAction = ObservableList();


  @readonly
  ObservableList<MonsterLegendaryAction> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<MonsterLegendaryAction> result = [];

    if(value.isEmpty){
      result = _listMonsterLegendaryAction;
    }else{
      result = _listMonsterLegendaryAction.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<MonsterLegendaryAction> newMonsterLegendaryActions){
    _listSearch.addAll(newMonsterLegendaryActions);
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
  int get itemCount => _lastPage ? _listMonsterLegendaryAction.length : _listMonsterLegendaryAction.length + 1;

  @computed
  bool get showProgress => _loading && _listMonsterLegendaryAction.isEmpty;

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
    _listMonsterLegendaryAction.clear();
    _lastPage = false;
  }

  @action
  void addNewMonsterLegendaryActions(List<MonsterLegendaryAction> newMonsterLegendaryActions) {
    if (newMonsterLegendaryActions.length < 15) _lastPage = true;
    _listMonsterLegendaryAction.addAll(newMonsterLegendaryActions);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listMonsterLegendaryAction.clear();

    try {
      final result = await MonsterLegendaryActionRepository().getAllLegendaryActions(page: page, filterSearchStore: filterSearchStore);
      addNewMonsterLegendaryActions(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Ações Lendárias dos Monstros!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Ações Lendárias dos Monstros');
    }

    setLoading(false);
  }
}