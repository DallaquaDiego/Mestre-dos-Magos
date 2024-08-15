import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MonsterAction {
  MonsterAction({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;


  @override
  String toString() {
    return 'MonsterAction{id: $id, name: $name, description: $description}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('MonsterAction')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!);
    return parseObject;
  }

  factory MonsterAction.fromParse(ParseObject parseObject) {
    return MonsterAction(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
    );
  }
}
