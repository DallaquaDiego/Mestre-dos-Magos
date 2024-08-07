import 'dart:developer';


import 'package:mestre_dos_magos/stores/filter_search_store.dart';

import 'package:mobx/mobx.dart';

import '../../models/item_category.dart';
import '../../repositories/item_category_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'item_category_store.g.dart';

class ItemCategoryStore = _ItemCategoryStore with _$ItemCategoryStore;

abstract class _ItemCategoryStore with Store {
  _ItemCategoryStore() {
    refreshData();

    autorun((_) async {
      await loadData(filterSearchStore: filterStore);
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
  ObservableList<ItemCategory> _listItemCategory = ObservableList();


  @readonly
  ObservableList<ItemCategory> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<ItemCategory> result = [];

    if(value.isEmpty){
      result = _listItemCategory;
    }else{
      result = _listItemCategory.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<ItemCategory> newItems){
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
  int get itemCount => _lastPage ? _listItemCategory.length : _listItemCategory.length + 1;

  @computed
  bool get showProgress => _loading && _listItemCategory.isEmpty;

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
    _listItemCategory.clear();
    _lastPage = false;
  }

  @action
  void addNewItems(List<ItemCategory> newItems) {
    if (newItems.length < 15) _lastPage = true;
    _listItemCategory.addAll(newItems);
  }

  @action
  Future<void> loadData({required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listItemCategory.clear();

    try {
      final result = await ItemCategoryRepository().getAllItemCategories(filterSearchStore: filterSearchStore);
      addNewItems(result);
      setListSearch(result);
    } catch (e, s) {
        log('Store: Erro ao Carregar Tipos de Combate!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Tipos de Combate');
    }

    setLoading(false);
  }
}
