import 'dart:developer';

import 'package:mestre_dos_magos/models/spell.dart';
import 'package:mestre_dos_magos/stores/filter_search_store.dart';

import 'package:mobx/mobx.dart';

import '../../repositories/spell_repository.dart';


/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'spell_store.g.dart';

class SpellStore = _SpellStore with _$SpellStore;

abstract class _SpellStore with Store {
  _SpellStore() {
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
  ObservableList<Spell> _listSpell = ObservableList();


  @readonly
  ObservableList<Spell> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<Spell> result = [];

    if(value.isEmpty){
      result = _listSpell;
    }else{
      result = _listSpell.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<Spell> newItems){
    _listSearch.addAll(newItems);
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
  int get itemCount => _lastPage ? _listSpell.length : _listSpell.length + 1;

  @computed
  bool get showProgress => _loading && _listSpell.isEmpty;

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
    _listSpell.clear();
    _lastPage = false;
  }

  @action
  void addNewItems(List<Spell> newItems) {
    if (newItems.length < 15) _lastPage = true;
    _listSpell.addAll(newItems);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listSpell.clear();

    try {
      final result = await SpellRepository().getAllSpells(page: _page, filterSearchStore: filterSearchStore);
      addNewItems(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Magias!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Magias');
    }

    setLoading(false);
  }
}