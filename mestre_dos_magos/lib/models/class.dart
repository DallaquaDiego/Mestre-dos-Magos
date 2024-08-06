import 'package:mestre_dos_magos/models/combat_type.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Class {
  Class({
    this.id,
    this.name,
    this.description,
    this.hp_per_level,
    this.primary_attributes,
    this.combat_type,
  });

  String? id;
  String? name;
  String? description;
  String? hp_per_level;
  CombatType? combat_type;
  String? primary_attributes;

  @override
  String toString() {
    return 'Class{id: $id, name: $name, description: $description, primary_attributes: $primary_attributes, hp_per_level: $hp_per_level, combat_type: $combat_type}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Class')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('hp_per_level', hp_per_level!)
      ..set('primary_attributes', primary_attributes!)
      ..set('combat_type', combat_type!.toParseObject());
    return parseObject;
  }

  factory Class.fromParse(ParseObject parseObject) {
    return Class(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      hp_per_level: parseObject.get<String>('hp_per_level'),
      primary_attributes: parseObject.get<String>('primary_attributes'),
      combat_type: parseObject.containsKey('combat_type') && parseObject.get<ParseObject>('combat_type') != null
        ? CombatType.fromParse(parseObject.get<ParseObject>('combat_type')!)
        : null,
    );
  }
}
