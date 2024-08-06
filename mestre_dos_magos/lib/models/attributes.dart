import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Attributes {
  Attributes({
    this.id,
    this.strength,
    this.constitution,
    this.dexterity,
    this.intelligence,
    this.wisdom,
    this.charisma,
  });

  String? id;
  int? strength;
  int? constitution;
  int? dexterity;
  int? intelligence;
  int? wisdom;
  int? charisma;

  @override
  String toString() {
    return 'Attributes{id: $id, strength: $strength, constitution: $constitution, dexterity: $dexterity, intelligence: $intelligence, wisdom: $wisdom, charisma: $charisma}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Attributes')
      ..objectId = id
      ..set('strength', strength)
      ..set('constitution', constitution)
      ..set('dexterity', dexterity)
      ..set('intelligence', intelligence)
      ..set('wisdom', wisdom)
      ..set('charisma', charisma);
    return parseObject;
  }

  factory Attributes.fromParse(ParseObject parseObject) {
    return Attributes(
      id: parseObject.objectId,
      strength: parseObject.get<int>('strength') ?? 0,
      constitution: parseObject.get<int>('constitution') ?? 0,
      dexterity: parseObject.get<int>('dexterity') ?? 0,
      intelligence: parseObject.get<int>('intelligence') ?? 0,
      wisdom: parseObject.get<int>('wisdom') ?? 0,
      charisma: parseObject.get<int>('charisma') ?? 0,
    );
  }
}
