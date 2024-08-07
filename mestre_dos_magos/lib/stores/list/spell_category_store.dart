import 'dart:developer';

import 'package:mestre_dos_magos/models/combat_type.dart';
import 'package:mestre_dos_magos/repositories/combat_type_repository.dart';
import 'package:mestre_dos_magos/stores/filter_search_store.dart';

import 'package:mobx/mobx.dart';

import '../../models/item_category.dart';
import '../../models/spell_category.dart';
import '../../repositories/item_category_repository.dart';
import '../../repositories/spell_category_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'spell_category_store.g.dart';

class SpellCategoryStore = _SpellCategoryStore with _$SpellCategoryStore;

abstract class _SpellCategoryStore with Store {
  _SpellCategoryStore() {
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
  ObservableList<SpellCategory> _listSpellCategory = ObservableList();


  @readonly
  ObservableList<SpellCategory> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<SpellCategory> result = [];

    if(value.isEmpty){
      result = _listSpellCategory;
    }else{
      result = _listSpellCategory.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<SpellCategory> newItems){
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
  int get itemCount => _lastPage ? _listSpellCategory.length : _listSpellCategory.length + 1;

  @computed
  bool get showProgress => _loading && _listSpellCategory.isEmpty;

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
    _listSpellCategory.clear();
    _lastPage = false;
  }

  @action
  void addNewItems(List<SpellCategory> newItems) {
    if (newItems.length < 15) _lastPage = true;
    _listSpellCategory.addAll(newItems);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listSpellCategory.clear();

    try {
      final result = await SpellCategoryRepository().getAllISpellCategories(page: page, filterSearchStore: filterSearchStore);
      addNewItems(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Categorias de Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Categorias de Magia');
    }

    setLoading(false);
  }
}
