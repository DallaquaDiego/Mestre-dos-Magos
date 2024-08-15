import 'package:mestre_dos_magos/models/race.dart';
import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SubRace {
  SubRace({
    this.id,
    this.name,
    this.description,
    this.parent_race,
    this.racial_trait,
  });

  String? id;
  String? name;
  String? description;
  Race? parent_race;
  List<RacialTrait>? racial_trait;

  @override
  String toString() {
    return 'SubRace{id: $id, name: $name, description: $description, parent_race: $parent_race, racial_trait: $racial_trait}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('SubRace')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('parent_race', parent_race!.toParseObject())
      ..set('sub_racial_trait', racial_trait!.map((racialT) => racialT.toParseObject()).toList());
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
      racial_trait: parseObject.get<List<dynamic>>('sub_racial_trait') != null
          ? _parseSubRacialTraits(parseObject.get<List<dynamic>>('sub_racial_trait')!)
          : [],
    );
  }

  static List<RacialTrait> _parseSubRacialTraits(List<dynamic> traits) {
    return traits.map((trait) {
      if (trait is ParseObject) {
        return RacialTrait.fromParse(trait);
      } else if (trait is String) {
        return RacialTrait(id: trait);
      } else {
        throw Exception("Unexpected type in racial traits list: ${trait.runtimeType}");
      }
    }).toList();
  }
}
