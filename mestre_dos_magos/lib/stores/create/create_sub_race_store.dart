import 'dart:developer';

import 'package:mestre_dos_magos/models/race.dart';
import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:mestre_dos_magos/repositories/racial_trait_repository.dart';
import 'package:mobx/mobx.dart';

import '../../models/sub_race.dart';
import '../../repositories/race_repository.dart';
import '../../repositories/sub_race_repository.dart';

/*Comando que precisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
dart run build_runner watch -d
*/

part 'create_sub_race_store.g.dart';

class CreateSubRaceStore = _CreateSubRaceStore with _$CreateSubRaceStore;

abstract class _CreateSubRaceStore with Store {
  _CreateSubRaceStore(this.subRace) {
    _name = subRace?.name ?? '';
    _description = subRace?.description ?? '';
    _parent_race = subRace?.parent_race;

    findRacialTraits().then((_) {
      _selectedRacialTraits = ObservableList<RacialTrait>.of(
        _listRacialTrait.where((racialTrait) =>
        subRace?.racial_trait?.any((selectedRacialTrait) => selectedRacialTrait.id == racialTrait.id) ?? false),
      );
    });
  }

  late SubRace? subRace;

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
  Race? _parent_race;

  @action
  void setParentRace(Race value) => _parent_race = value;

  @computed
  bool get parentRaceValid => _parent_race != null;

  String? get parentRaceError {
    if (!showErrors || parentRaceValid) {
      return null;
    } else if (!parentRaceValid) {
      return 'Campo Obrigatório';
    } else {
      return ('Categoria inválida');
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
                          racialTraitValid && parentRaceValid && !_loading;

  @computed
  dynamic get createPressed => isFormValid ? _createSubRace : null;

  dynamic get editPressed => isFormValid ? _editSubRace : null;

  Future<void> _createSubRace() async {
    setError(null);
    setLoading(true);

    subRace = SubRace(
      name: _name,
      description: _description,
      parent_race: _parent_race,
      racial_trait: _selectedRacialTraits,
    );

    try {
      await SubRaceRepository().createSubRace(subRace!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Criar Sub-Raça!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> _editSubRace() async {
    setError(null);
    setLoading(true);

    subRace!.name = _name;
    subRace!.description = _description;
    subRace!.parent_race = _parent_race;
    subRace!.racial_trait = _selectedRacialTraits;

    try {
      await SubRaceRepository().updateSubRace(subRace!);
      setSavedOrUpdatedOrDeleted(true);
    } catch (e, s) {
      log('Store: Erro ao Editar Sub-Raça!', error: e.toString(), stackTrace: s);
      setError(e.toString());
    }

    setLoading(false);
  }

  @action
  Future<void> deleteSubRace() async {
    setError(null);
    setLoading(true);

    try {
      await SubRaceRepository().deleteSubRace(subRace!.id!);
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