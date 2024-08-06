import 'package:mestre_dos_magos/models/attributes.dart';
import 'package:mestre_dos_magos/models/class.dart';
import 'package:mestre_dos_magos/models/item.dart';
import 'package:mestre_dos_magos/models/race.dart';
import 'package:mestre_dos_magos/models/spell.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Player {
  Player({
    this.id,
    this.name,
    this.age,
    this.hp,
    this.level,
    this.cd,
    this.ca,
    this.classes,
    this.race,
    this.attributes,
    this.itens,
    this.spells,
  });

  String? id;
  String? name;
  int? age;
  int? hp;
  int? level;
  int? cd;
  int? ca;
  Class? classes;
  Race? race;
  Attributes? attributes;
  List<Item>? itens;
  List<Spell>? spells;
 

  @override
  String toString() {
    return 'Player{id: $id, name: $name, age: $age, hp: $hp, level: $level, cd: $cd, ca: $ca, class: $classes, race: $race, attributes: $attributes, itens: $itens, spells: $spells}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Player')
      ..objectId = id
      ..set('name', name)
      ..set('age', age)
      ..set('hp', hp)
      ..set('level', level)
      ..set('cd', cd)
      ..set('ca', ca)
      ..set('classId', classes!.id!)
      ..set('raceId', race!.id!)
      ..set('attributesId', attributes!.id!)
      ..set('itensId', itens!.map((item) => item.id!).toList())
      ..set('spellsId', spells!.map((spell) => spell.id!).toList());
    return parseObject;
  }

  factory Player.fromParse(ParseObject parseObject) {
    return Player(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      age: parseObject.get<int>('age'),
      hp: parseObject.get<int>('hp'),
      level: parseObject.get<int>('level'),
      cd: parseObject.get<int>('cd'),
      ca: parseObject.get<int>('ca'),
      classes: parseObject.containsKey('class') && parseObject.get<ParseObject>('class') != null
          ? Class.fromParse(parseObject.get<ParseObject>('class')!)
          : null,
      race: parseObject.containsKey('race') && parseObject.get<ParseObject>('race') != null
          ? Race.fromParse(parseObject.get<ParseObject>('race')!)
          : null,
      attributes: parseObject.containsKey('attributes') && parseObject.get<ParseObject>('attributes') != null
          ? Attributes.fromParse(parseObject.get<ParseObject>('attributes')!)
          : null,
      itens: parseObject.containsKey('itens')
          ? (parseObject.get<List<ParseObject>>('itens') ?? []).map((item) => Item.fromParse(item)).toList()
          : [],
      spells: parseObject.containsKey('spells')
          ? (parseObject.get<List<ParseObject>>('spells') ?? []).map((spell) => Spell.fromParse(spell)).toList()
          : [],
    );
  }
}
