import 'package:mestre_dos_magos/models/race.dart';
import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SubRace {
  SubRace({
    this.id,
    this.name,
    this.description,
    this.parent_race,
    this.racial_traits,
  });

  String? id;
  String? name;
  String? description;
  Race? parent_race;
  List<RacialTrait>? racial_traits;

  @override
  String toString() {
    return 'SubRace{id: $id, name: $name, description: $description, parent_race: $parent_race, racial_traits: $racial_traits}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('SubRace')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('parent_race', parent_race!.toParseObject())
      ..set('racial_traits', racial_traits!.map((racialT) => racialT.toParseObject()).toList());
    return parseObject;
  }

  factory SubRace.fromParse(ParseObject parseObject) {
    return SubRace(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      parent_race: parseObject.containsKey('parent_race') && parseObject.get<ParseObject>('parent_race') != null
          ? Race.fromParse(parseObject.get<ParseObject>('parent_race')!)
          : null,
      racial_traits: parseObject.containsKey('racial_traits')
          ? _parseRacialTraits(parseObject.get<List<dynamic>>('racial_traits')!)
          : [],
    );
  }

  static List<RacialTrait> _parseRacialTraits(List<dynamic> traits) {
    // Verifica se os traits são objetos completos ou apenas IDs
    if (traits.isEmpty || traits.first is ParseObject) {
      return traits.map((trait) => RacialTrait.fromParse(trait as ParseObject)).toList();
    } else {
      // Se são apenas IDs, busque os objetos completos
      return traits.map((id) => RacialTrait(id: id as String)).toList();
    }
  }
}
