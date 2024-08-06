import 'dart:developer';

import 'package:mestre_dos_magos/stores/filter_search_store.dart';
import 'package:mobx/mobx.dart';

import '../models/item.dart';
import '../repositories/item_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'item_store.g.dart';

class ItemStore = _ItemStore with _$ItemStore;

abstract class _ItemStore with Store {
  _ItemStore() {
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
  ObservableList<Item> _listItem = ObservableList();


  @readonly
  ObservableList<Item> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<Item> result = [];

    if(value.isEmpty){
      result = _listItem;
    }else{
      result = _listItem.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<Item> newItems){
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
  int get itemCount => _lastPage ? _listItem.length : _listItem.length + 1;

  @computed
  bool get showProgress => _loading && _listItem.isEmpty;

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
    _listItem.clear();
    _lastPage = false;
  }

  @action
  void addNewItems(List<Item> newItems) {
    if (newItems.length < 15) _lastPage = true;
    _listItem.addAll(newItems);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listItem.clear();

    try {
      final result = await ItemRepository().getAllItems(page: _page, filterSearchStore: filterSearchStore);
      addNewItems(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Itens!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Itens');
    }

    setLoading(false);
  }
}