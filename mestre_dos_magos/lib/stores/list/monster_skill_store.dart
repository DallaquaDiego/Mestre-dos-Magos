import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/monster_skill.dart';
import '../../repositories/monster_skill_repository.dart';
import '../filter_search_store.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'monster_skill_store.g.dart';

class MonsterSkillStore = _MonsterSkillStore with _$MonsterSkillStore;

abstract class _MonsterSkillStore with Store {
  _MonsterSkillStore() {
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
  ObservableList<MonsterSkill> _listMonsterSkill = ObservableList();


  @readonly
  ObservableList<MonsterSkill> _listSearch = ObservableList();

  @action
  void runFilter(String value){
    List<MonsterSkill> result = [];

    if(value.isEmpty){
      result = _listMonsterSkill;
    }else{
      result = _listMonsterSkill.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    }

    _listSearch.clear();

    _listSearch.addAll(result);

  }

  @action
  void setListSearch(List<MonsterSkill> newMonsterSkills){
    _listSearch.addAll(newMonsterSkills);
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
  int get itemCount => _lastPage ? _listMonsterSkill.length : _listMonsterSkill.length + 1;

  @computed
  bool get showProgress => _loading && _listMonsterSkill.isEmpty;

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
    _listMonsterSkill.clear();
    _lastPage = false;
  }

  @action
  void addNewMonsterSkills(List<MonsterSkill> newMonsterSkills) {
    if (newMonsterSkills.length < 15) _lastPage = true;
    _listMonsterSkill.addAll(newMonsterSkills);
  }

  @action
  Future<void> loadData({int? page, required FilterSearchStore filterSearchStore}) async {
    setError(null);
    setLoading(true);

    if (_page == 1) _listMonsterSkill.clear();

    try {
      final result = await MonsterSkillRepository().getAllSkills(page: page, filterSearchStore: filterSearchStore);
      addNewMonsterSkills(result);
      setListSearch(result);
    } catch (e, s) {
      log('Store: Erro ao Carregar Habilidades dos Monstros!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Carregar Habilidades dos Monstros');
    }

    setLoading(false);
  }
}