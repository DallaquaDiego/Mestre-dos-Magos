import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MonsterLegendaryAction {
  MonsterLegendaryAction({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;

  @override
  String toString() {
    return 'MonsterLegendaryAction{id: $id, name: $name, description: $description}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('MonsterLegendaryAction')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!);
    return parseObject;
  }

  factory MonsterLegendaryAction.fromParse(ParseObject parseObject) {
    return MonsterLegendaryAction(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
    );
  }
}
