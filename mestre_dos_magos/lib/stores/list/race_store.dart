import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/race.dart';
import '../../repositories/race_repository.dart';
import 'package:mestre_dos_magos/stores/filter_search_store.dart';



/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'race_store.g.dart';

class RaceStore = _RaceStore with _$RaceStore;

abstract class _RaceStore with Store {
  _RaceStore() {
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
  ObservableList<Race> _listRace = ObservableList();


  @readonly
  ObservableList<Race> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<Race> result = [];

    if(value.isEmpty){
      result = _listRace;
    }else{
      result = _listRace.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);
  }

  @action
  void setListSearch(List<Race> newRaces){
    _listSearch.addAll(newRaces);
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
  int get itemCount => _lastPage ? _listRace.length : _listRace.length + 1;

  @computed
  bool get showProgress => _loading && _listRace.isEmpty;

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
    _listRace.clear();
    _lastPage = false;
  }

  @action
  void addNewRaces(List<Race> newRaces) {
    if (newRaces.length < 15) _lastPage = true;
    _listRace.addAll(newRaces);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listRace.clear();

    try {
      final result = await RaceRepository().getAllRaces(page: page, filterSearchStore: filterSearchStore);
      addNewRaces(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Raças!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Raças');
    }

    setLoading(false);
  }
}