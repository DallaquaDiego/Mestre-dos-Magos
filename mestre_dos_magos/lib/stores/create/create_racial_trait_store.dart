import 'dart:developer';

import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/racial_trait_repository.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_racial_trait_store.g.dart';

class CreateRacialTraitStore = _CreateRacialTraitStore with _$CreateRacialTraitStore;

abstract class _CreateRacialTraitStore with Store {
  _CreateRacialTraitStore(this.racialTrait) {
    _name = racialTrait?.name ?? '';
    _description = racialTrait?.description ?? '';
  }

  late RacialTrait? racialTrait;

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
  bool get isFormValid => nameValid && descriptionValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createRacialTrait : null;

  dynamic get editPressed => isFormValid ? _editRacialTrait : null;

  Future<void> _createRacialTrait() async {
    setError(null);
    setLoading(true);

    racialTrait = RacialTrait(
      name: _name,
      description: _description,
    );

    try {
      await RacialTraitRepository().createRacialTrait(racialTrait!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Traço Racial!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editRacialTrait() async {
    setError(null);
    setLoading(true);

    racialTrait!.name = _name;
    racialTrait!.description = _description;


    try {
      await RacialTraitRepository().updateRacialTrait(racialTrait!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Traço Racial!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteRacialTrait() async {
    setError(null);
    setLoading(true);

    try {
      await RacialTraitRepository().deleteRacialTrait(racialTrait!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar Traço Racial!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}