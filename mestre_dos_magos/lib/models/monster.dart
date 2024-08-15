import 'package:mestre_dos_magos/models/monster_action.dart';
import 'package:mestre_dos_magos/models/monster_legendary_action.dart';
import 'package:mestre_dos_magos/models/monster_skill.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Monster {
  Monster({
    this.id,
    this.name,
    this.description,
    this.ca,
    this.hp,
    this.endurance_tests,
    this.expertise,
    this.challenge_level,
    this.skills,
    this.actions,
    this.legendary_actions,
    this.strength,
    this.constitution,
    this.dexterity,
    this.intelligence,
    this.wisdom,
    this.charisma,
  });

  String? id;
  String? name;
  String? description;
  int? ca;
  int? hp;
  String? endurance_tests;
  String? expertise;
  int? challenge_level;
  List<MonsterSkill>? skills;
  List<MonsterAction>? actions;
  List<MonsterLegendaryAction>? legendary_actions;
  int? strength;
  int? constitution;
  int? dexterity;
  int? intelligence;
  int? wisdom;
  int? charisma;

  @override
  String toString() {
    return 'Monster{id: $id, name: $name, description: $description, ca: $ca, hp: $hp, endurance_tests: $endurance_tests, expertise: $expertise, challenge_level: $challenge_level, skills: $skills, actions: $actions, legendary_actions: $legendary_actions, strength: $strength, constitution: $constitution, dexterity: $dexterity, intelligence: $intelligence, wisdom: $wisdom, charisma: $charisma}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Monster')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('ca', ca!)
      ..set('hp', hp!)
      ..set('endurance_tests', endurance_tests!)
      ..set('expertise', expertise!)
      ..set('challenge_level', challenge_level!)
      ..set('skills', skills!.map((skill) => skill.toParseObject()).toList())
      ..set('actions', actions!.map((skill) => skill.toParseObject()).toList())
      ..set('legendary_actions', legendary_actions!.map((skill) => skill.toParseObject()).toList())
      ..set('strength', strength!)
      ..set('constitution', constitution!)
      ..set('dexterity', dexterity!)
      ..set('intelligence', intelligence!)
      ..set('wisdom', wisdom!)
      ..set('charisma', charisma!);
    return parseObject;
  }

  factory Monster.fromParse(ParseObject parseObject) {
    return Monster(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      ca: parseObject.get<int>('ca'),
      hp: parseObject.get<int>('hp'),
      endurance_tests: parseObject.get<String>('endurance_tests'),
      expertise: parseObject.get<String>('expertise'),
      challenge_level: parseObject.get<int>('challenge_level'),
      skills: parseObject.get<List<dynamic>>('skills') != null
          ? _parseMonsterSkill(parseObject.get<List<dynamic>>('skills')!)
          : [],
      actions: parseObject.get<List<dynamic>>('actions') != null
          ? _parseMonsterAction(parseObject.get<List<dynamic>>('actions')!)
          : [],
      legendary_actions: parseObject.get<List<dynamic>>('legendary_actions') != null
          ? _parseMonsterLegendaryAction(parseObject.get<List<dynamic>>('legendary_actions')!)
          : [],
      strength: parseObject.get<int>('strength') ?? 0,
      constitution: parseObject.get<int>('constitution') ?? 0,
      dexterity: parseObject.get<int>('dexterity') ?? 0,
      intelligence: parseObject.get<int>('intelligence') ?? 0,
      wisdom: parseObject.get<int>('wisdom') ?? 0,
      charisma: parseObject.get<int>('charisma') ?? 0,
    );
  }

  static List<MonsterSkill> _parseMonsterSkill(List<dynamic> skills) {
    return skills.map((skill) {
      if (skill is ParseObject) {
        return MonsterSkill.fromParse(skill);
      } else if (skill is String) {
        return MonsterSkill(id: skill);
      } else {
        throw Exception("Unexpected type in skills list: ${skill.runtimeType}");
      }
    }).toList();
  }

  static List<MonsterAction> _parseMonsterAction(List<dynamic> actions) {
    return actions.map((action) {
      if (action is ParseObject) {
        return MonsterAction.fromParse(action);
      } else if (action is String) {
        return MonsterAction(id: action);
      } else {
        throw Exception("Unexpected type in actions list: ${action.runtimeType}");
      }
    }).toList();
  }

  static List<MonsterLegendaryAction> _parseMonsterLegendaryAction(List<dynamic> legendaryActions) {
    return legendaryActions.map((action) {
      if (action is ParseObject) {
        return MonsterLegendaryAction.fromParse(action);
      } else if (action is String) {
        return MonsterLegendaryAction(id: action);
      } else {
        throw Exception("Unexpected type in legendary actions list: ${action.runtimeType}");
      }
    }).toList();
  }
}
