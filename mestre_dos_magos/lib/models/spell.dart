import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Spell {
  Spell({
    this.id,
    this.name,
    this.description,
    this.damage,
    this.effectOnFoe,
    this.effectOnAlly,
    this.isTrick,
  });

  String? id;
  String? name;
  String? description;
  String? damage;
  String? effectOnFoe;
  String? effectOnAlly;
  bool? isTrick;

  @override
  String toString() {
    return 'Spell{id: $id, name: $name, description: $description, damage: $damage, effectOnFoe: $effectOnFoe, effectOnAlly: $effectOnAlly, isTrick: $isTrick}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Spell')
      ..objectId = id
      ..set('name', name)
      ..set('description', description)
      ..set('damage', damage)
      ..set('effect_on_foe', effectOnFoe)
      ..set('effect_on_ally', effectOnAlly)
      ..set('isTrick', isTrick);
    return parseObject;
  }

  factory Spell.fromParse(ParseObject parseObject) {
    return Spell(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      damage: parseObject.get<String>('damage'),
      effectOnFoe: parseObject.get<String>('effect_on_foe'),
      effectOnAlly: parseObject.get<String>('effect_on_ally'),
      isTrick: parseObject.get<bool>('isTrick'),
    );
  }
}
