import 'dart:developer';

import 'package:mestre_dos_magos/models/race.dart';
import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:mestre_dos_magos/repositories/racial_trait_repository.dart';
import 'package:mobx/mobx.dart';

import '../../repositories/race_repository.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_race_store.g.dart';

class CreateRaceStore = _CreateRaceStore with _$CreateRaceStore;

abstract class _CreateRaceStore with Store {
  _CreateRaceStore(this.race) {
    _name = race?.name ?? '';
    _description = race?.description ?? '';

    findRacialTraits().then((_) {
      _selectedRacialTraits = ObservableList<RacialTrait>.of(
        _listRacialTrait.where((racialTrait) =>
        race?.racial_trait?.any((selectedRacialTrait) => selectedRacialTrait.id == racialTrait.id) ?? false),
      );
    });
  }

  late Race? race;

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
  ObservableList<RacialTrait> _selectedRacialTraits = ObservableList();

  @readonly
  ObservableList<RacialTrait> _listRacialTrait = ObservableList();

  @action
  void addRacialTraits(List<RacialTrait> newRacialTraits) {
    _selectedRacialTraits.clear();
    _selectedRacialTraits.addAll(newRacialTraits);
  }

  @action
  void removeRacialTrait(RacialTrait racialTraitToRemove) {
    _selectedRacialTraits.removeWhere((racialTrait) => racialTrait.id == racialTraitToRemove.id);
  }

  @computed
  bool get racialTraitValid => _selectedRacialTraits.isNotEmpty;

  @computed
  String? get racialTraitError {
    if (!showErrors || racialTraitValid) {
      return null;
    } else {
      return 'Campo obrigatório';
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
                          racialTraitValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createRace : null;

  dynamic get editPressed => isFormValid ? _editRace : null;

  Future<void> _createRace() async {
    setError(null);
    setLoading(true);

    race = Race(
      name: _name,
      description: _description,
      racial_trait: _selectedRacialTraits,
    );

    try {
      await RaceRepository().createRace(race!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Raça!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editRace() async {
    setError(null);
    setLoading(true);

    race!.name = _name;
    race!.description = _description;
    race!.racial_trait = _selectedRacialTraits;

    try {
      await RaceRepository().updateRace(race!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Raça!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteRace() async {
    setError(null);
    setLoading(true);

    try {
      await RaceRepository().deleteRace(race!.id!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Deletar Raça!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> findRacialTraits() async {
    setError(null);
    setLoading(true);

    try {
      final result = await RacialTraitRepository().getAllRacialTraits();
      _listRacialTrait.clear();
      _listRacialTrait.addAll(result);
    } catch (e, s) {
      log('Store: Erro ao buscar Traços Raciais!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }
}