import 'package:mestre_dos_magos/models/spell_category.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Spell {
  Spell({
    this.id,
    this.name,
    this.description,
    this.isTrick,
    this.spell_level,
    this.spell_category,
    this.duration,
    this.damage,
    this.effect_on_foe,
    this.effect_on_ally,
  });

  String? id;
  String? name;
  String? description;
  bool? isTrick;
  int? spell_level;
  SpellCategory? spell_category;
  String? duration;
  String? damage;
  String? effect_on_foe;
  String? effect_on_ally;
  

  @override
  String toString() {
    return 'Spell{id: $id, name: $name, description: $description, isTrick: $isTrick, spell_level: $spell_level, duration:$duration, damage: $damage, effect_on_foe: $effect_on_foe, effect_on_ally: $effect_on_ally, spell_category: $spell_category}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Spell')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('is_trick', isTrick!)
      ..set('spell_level', spell_level!)
      ..set('category', spell_category!.toParseObject())
      ..set('duration', duration!)
      ..set('damage', damage)
      ..set('effect_on_foe', effect_on_foe)
      ..set('effect_on_ally', effect_on_ally);
    return parseObject;
  }

  factory Spell.fromParse(ParseObject parseObject) {
    return Spell(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      isTrick: parseObject.get<bool>('is_trick'),
      spell_level: parseObject.get<int>('spell_level'),
      duration: parseObject.get<String>('duration'),
      damage: parseObject.get<String>('damage'),
      effect_on_foe: parseObject.get<String>('effect_on_foe'),
      effect_on_ally: parseObject.get<String>('effect_on_ally'),
      spell_category: parseObject.containsKey('category') && parseObject.get<ParseObject>('category') != null
          ? SpellCategory.fromParse(parseObject.get<ParseObject>('category')!)
          : null,
    );
  }
}
