import 'dart:developer';

import 'package:mestre_dos_magos/models/class.dart';
import 'package:mestre_dos_magos/models/item.dart';
import 'package:mobx/mobx.dart';

import '../models/combat_type.dart';
import '../models/item_category.dart';
import '../repositories/class_repository.dart';
import '../repositories/item_repository.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_item_store.g.dart';

class CreateItemStore = _CreateItemStore with _$CreateItemStore;

abstract class _CreateItemStore with Store {
  _CreateItemStore(this.item) {
    _name = item?.name ?? '';
    _description = item?.description ?? '';
    _item_category = item?.itemCategory;
    _price = item?.price.toString() ?? '';
    _damage = item?.damage ?? '';
    _effect = item?.effect ?? '';
  }

  late Item? item;

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
  String _description = '';

  @action
  void setDescription(String value) => _description = value;

  @computed
  bool get descriptionValid => _description.length >= 3;

  String? get descriptionError {
    if (!showErrors || descriptionValid) {
      return null;
    } else if (_description.isEmpty) {
      return 'Campo Obrigatório';
    } else if (_description.length < 3) {
      return 'Descrição muito curta';
    } else {
      return ('Descrição inválida');
    }
  }

  @readonly
  String _price = '';

  @action
  void setPrice(String value) => _price = value;

  @computed
  bool get priceValid => int.tryParse(_price) != null && int.tryParse(_price)! >= 0;

  String? get priceError {
    if (!showErrors || priceValid) {
      return null;
    } else {
      return 'Campo Obrigatório';
    }
  }

  @readonly
  String _damage = '';

  @action
  void setDamage(String value) => _damage = value;

  String? get damageError {
    if (!showErrors) {
      return null;
    } else {
      return ('Campo Obrigatório');
    }
  }

  @readonly
  String _effect = '';

  @action
  void setEffect(String value) => _effect = value;

  String? get effectError {
    if (!showErrors) {
      return null;
    } else {
      return ('Campo Obrigatório');
    }
  }

  @readonly
  ItemCategory? _item_category;

  @action
  void setItemCategory(ItemCategory value) => _item_category = value;

  @computed
  bool get itemCategoryValid => _item_category != null;

  String? get itemCategoryError {
    if (!showErrors || itemCategoryValid) {
      return null;
    } else if (!itemCategoryValid) {
      return 'Campo Obrigatório';
    } else {
      return ('Categoria inválida');
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
  bool get isFormValid => nameValid && descriptionValid &&
                          priceValid && itemCategoryValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createItem : null;

  dynamic get editPressed => isFormValid ? _editItem : null;

  Future<void> _createItem() async {
    setError(null);
    setLoading(true);

    item = Item(
      name: _name,
      description: _description,
      price: int.parse(_price),
      damage: _damage,
      effect: _effect,
      itemCategory: _item_category!,
    );

    try {
      await ItemRepository().createItem(item!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar item!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editItem() async {
    setError(null);
    setLoading(true);

    item!.name = _name;
    item!.description = _description;
    item!.price = int.parse(_price);
    item!.damage = _damage;
    item!.effect = _effect;
    item!.itemCategory = _item_category!;

    try {
      await ItemRepository().updateItem(item!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar item!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteItem() async {
    setError(null);
    setLoading(true);

    try {
      await ItemRepository().deleteItem(item!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar item!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}