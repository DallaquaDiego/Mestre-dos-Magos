import 'package:mestre_dos_magos/models/class.dart';
import 'package:mestre_dos_magos/models/item.dart';
import 'package:mestre_dos_magos/models/race.dart';
import 'package:mestre_dos_magos/models/spell.dart';
import 'package:mestre_dos_magos/models/sub_race.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Player {
  Player({
    this.id,
    this.name,
    this.age,
    this.hp,
    this.current_hp,
    this.level,
    this.cd,
    this.ca,
    this.classe,
    this.race,
    this.sub_race,
    this.itens,
    this.spells,
    this.strength,
    this.constitution,
    this.dexterity,
    this.intelligence,
    this.wisdom,
    this.charisma,
  });

  String? id;
  String? name;
  int? age;
  int? hp;
  int? current_hp;
  int? level;
  int? cd;
  int? ca;
  Class? classe;
  Race? race;
  SubRace? sub_race;
  List<Item>? itens;
  List<Spell>? spells;
  int? strength;
  int? constitution;
  int? dexterity;
  int? intelligence;
  int? wisdom;
  int? charisma;
 

  @override
  String toString() {
    return 'Player{id: $id, name: $name, age: $age, hp: $hp, current_hp: $current_hp, level: $level, cd: $cd, ca: $ca, class: $classe, race: $race, sub_race: $sub_race, strength: $strength, constitution: $constitution, dexterity: $dexterity, intelligence: $intelligence, wisdom: $wisdom, charisma: $charisma, itens: $itens, spells: $spells}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Player')
      ..objectId = id
      ..set('name', name!)
      ..set('age', age)
      ..set('hp', hp!)
      ..set('current_hp', current_hp!)
      ..set('level', level!)
      ..set('cd', cd!)
      ..set('ca', ca!)
      ..set('class', classe!.toParseObject())
      ..set('race', race!.toParseObject())
      ..set('sub_race', sub_race?.toParseObject())
      ..set('strength', strength!)
      ..set('constitution', constitution!)
      ..set('dexterity', dexterity!)
      ..set('intelligence', intelligence!)
      ..set('wisdom', wisdom!)
      ..set('charisma', charisma!)
      ..set('itens', itens!.map((item) => item.toParseObject()).toList())
      ..set('spells', spells!.map((spell) => spell.toParseObject()).toList());
    return parseObject;
  }



  factory Player.fromParse(ParseObject parseObject) {
    return Player(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      age: parseObject.get<int>('age'),
      hp: parseObject.get<int>('hp'),
      current_hp: parseObject.get<int>('current_hp'),
      level: parseObject.get<int>('level'),
      cd: parseObject.get<int>('cd'),
      ca: parseObject.get<int>('ca'),
      strength: parseObject.get<int>('strength') ?? 0,
      constitution: parseObject.get<int>('constitution') ?? 0,
      dexterity: parseObject.get<int>('dexterity') ?? 0,
      intelligence: parseObject.get<int>('intelligence') ?? 0,
      wisdom: parseObject.get<int>('wisdom') ?? 0,
      charisma: parseObject.get<int>('charisma') ?? 0,
      classe: parseObject.containsKey('class') && parseObject.get<ParseObject>('class') != null
          ? Class.fromParse(parseObject.get<ParseObject>('class')!)
          : null,
      race: parseObject.containsKey('race') && parseObject.get<ParseObject>('race') != null
          ? Race.fromParse(parseObject.get<ParseObject>('race')!)
          : null,
      sub_race: parseObject.containsKey('sub_race') && parseObject.get<ParseObject>('sub_race') != null
          ? SubRace.fromParse(parseObject.get<ParseObject>('sub_race')!)
          : null,
      itens: parseObject.containsKey('itens')
          ? _parseItens(parseObject.get<List<dynamic>>('itens')!)
          : [],
      spells: parseObject.containsKey('spells')
          ? _parseSpells(parseObject.get<List<dynamic>>('spells')!)
          : [],
    );
  }

  static List<Spell> _parseSpells(List<dynamic> traits) {
    return traits.map((trait) {
      if (trait is ParseObject) {
        return Spell.fromParse(trait);
      } else if (trait is String) {
        return Spell(id: trait);
      } else {
        throw Exception("Unexpected type in racial traits list: ${trait.runtimeType}");
      }
    }).toList();
  }

  static List<Item> _parseItens(List<dynamic> traits) {
    return traits.map((trait) {
      if (trait is ParseObject) {
        return Item.fromParse(trait);
      } else if (trait is String) {
        return Item(id: trait);
      } else {
        throw Exception("Unexpected type in racial traits list: ${trait.runtimeType}");
      }
    }).toList();
  }
}
