import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MonsterSkill {
  MonsterSkill({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;


  @override
  String toString() {
    return 'MonsterSkill{id: $id, name: $name, description: $description}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('MonsterSkill')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!);
    return parseObject;
  }

  factory MonsterSkill.fromParse(ParseObject parseObject) {
    return MonsterSkill(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
    );
  }
}
