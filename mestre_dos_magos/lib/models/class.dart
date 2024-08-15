import 'package:mestre_dos_magos/models/combat_type.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Class {
  Class({
    this.id,
    this.name,
    this.description,
    this.hp_per_level,
    this.primary_attributes,
    this.resistance_proficiency,
    this.weapon_and_armor_proficiency,
    this.combat_type,
  });

  String? id;
  String? name;
  String? description;
  String? hp_per_level;
  String? primary_attributes;
  String? resistance_proficiency;
  String? weapon_and_armor_proficiency;
  CombatType? combat_type;


  @override
  String toString() {
    return 'Class{id: $id, name: $name, description: $description, primary_attributes: $primary_attributes, hp_per_level: $hp_per_level, resistance_proficiency: $resistance_proficiency, weapon_and_armor_proficiency: $weapon_and_armor_proficiency, combat_type: $combat_type}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Class')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('hp_per_level', hp_per_level!)
      ..set('primary_attributes', primary_attributes!)
      ..set('resistance_proficiency', resistance_proficiency!)
      ..set('weapon_and_armor_proficiency', weapon_and_armor_proficiency!)
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
      resistance_proficiency: parseObject.get<String>('resistance_proficiency'),
      weapon_and_armor_proficiency: parseObject.get<String>('weapon_and_armor_proficiency'),
      combat_type: parseObject.containsKey('combat_type') && parseObject.get<ParseObject>('combat_type') != null
        ? CombatType.fromParse(parseObject.get<ParseObject>('combat_type')!)
        : null,
    );
  }
}
