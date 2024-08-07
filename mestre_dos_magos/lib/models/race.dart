import 'package:mestre_dos_magos/models/racial_trait.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Race {
  Race({
    this.id,
    this.name,
    this.description,
    this.racial_traits,
  });

  String? id;
  String? name;
  String? description;
  List<RacialTrait>? racial_traits;


  @override
  String toString() {
    return 'Race{id: $id, name: $name, description: $description, racial_traits: $racial_traits}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Race')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('racial_traits', racial_traits!.map((racialT) => racialT.toParseObject()).toList());
    return parseObject;
  }

  factory Race.fromParse(ParseObject parseObject) {
    return Race(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
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
