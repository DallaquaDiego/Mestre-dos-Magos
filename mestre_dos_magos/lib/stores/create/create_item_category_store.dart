import 'dart:developer';

import 'package:mestre_dos_magos/models/item_category.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/item_category_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_item_category_store.g.dart';

class CreateItemCategoryStore = _CreateItemCategoryStore with _$CreateItemCategoryStore;

abstract class _CreateItemCategoryStore with Store {
  _CreateItemCategoryStore(this.itemCategory) {
    _name = itemCategory?.name ?? '';
  }

  late ItemCategory? itemCategory;

  @readonly
  String _name = '';

  @action
  void setName(String value) => _name = value;

  @computed
  bool get nameValid => _name.length >= 3;

  String? get nameError {
    if (!showErrors || nameValid) {
      return null;
    } else if (_name.isEmpty) {
      return 'Campo Obrigatório';
    } else if (_name.length < 3) {
      return 'Nome muito curto';
    } else {
      return ('Nome inválido');
    }
  }

  @readonly
  bool _savedOrUpdatedOrDeleted = false;

  @action
  void setSavedOrUpdatedOrDeleted(bool value) => _savedOrUpdatedOrDeleted = value;

  @readonly
  bool _loading = false;

  @action
  void setLoading(bool value) => _loading = value;

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @computed
  bool get isFormValid => nameValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createItemCategory : null;

  dynamic get editPressed => isFormValid ? _editItemCategory : null;

  Future<void> _createItemCategory() async {
    setError(null);
    setLoading(true);

    itemCategory = ItemCategory(
      name: _name,
    );

    try {
      await ItemCategoryRepository().createItemCategory(itemCategory!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Categoria!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editItemCategory() async {
    setError(null);
    setLoading(true);

    itemCategory!.name = _name;

    try {
      await ItemCategoryRepository().updateItemCategory(itemCategory!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Categoria!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteItemCategory() async {
    setError(null);
    setLoading(true);

    try {
      await ItemCategoryRepository().deleteItemCategory(itemCategory!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar Categoria!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}