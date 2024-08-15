import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Race {
  Race({
    this.id,
    this.name,
    this.description,
    this.racial_trait,
  });

  String? id;
  String? name;
  String? description;
  List<RacialTrait>? racial_trait;


  @override
  String toString() {
    return 'Race{id: $id, name: $name, description: $description, racial_trait: $racial_trait}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Race')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('racial_trait', racial_trait!.map((racialT) => racialT.toParseObject()).toList());
    return parseObject;
  }

  factory Race.fromParse(ParseObject parseObject) {
    return Race(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      racial_trait: parseObject.get<List<dynamic>>('racial_trait') != null
          ? _parseRacialTrait(parseObject.get<List<dynamic>>('racial_trait')!)
          : [],
    );
  }

  static List<RacialTrait> _parseRacialTrait(List<dynamic> traits) {
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
