import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/sub_race.dart';
import '../../repositories/sub_race_repository.dart';
import 'package:mestre_dos_magos/stores/filter_search_store.dart';



/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'sub_race_store.g.dart';

class SubRaceStore = _SubRaceStore with _$SubRaceStore;

abstract class _SubRaceStore with Store {
  _SubRaceStore() {
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
  ObservableList<SubRace> _listSubRace = ObservableList();


  @readonly
  ObservableList<SubRace> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<SubRace> result = [];

    if(value.isEmpty){
      result = _listSubRace;
    }else{
      result = _listSubRace.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);
  }

  @action
  void setListSearch(List<SubRace> newSubRaces){
    _listSearch.addAll(newSubRaces);
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
  int get itemCount => _lastPage ? _listSubRace.length : _listSubRace.length + 1;

  @computed
  bool get showProgress => _loading && _listSubRace.isEmpty;

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
    _listSubRace.clear();
    _lastPage = false;
  }

  @action
  void addNewSubRaces(List<SubRace> newSubRaces) {
    if (newSubRaces.length < 15) _lastPage = true;
    _listSubRace.addAll(newSubRaces);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listSubRace.clear();

    try {
      final result = await SubRaceRepository().getAllSubRaces(page: page, filterSearchStore: filterSearchStore);
      addNewSubRaces(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Sub-Raças!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Sub-Raças');
    }

    setLoading(false);
  }
}