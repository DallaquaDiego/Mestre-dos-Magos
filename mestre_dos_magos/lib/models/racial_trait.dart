import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RacialTrait {
  RacialTrait({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;


  @override
  String toString() {
    return 'RacialTrait{id: $id, name: $name, description: $description}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('RacialTrait')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!);
    return parseObject;
  }

  factory RacialTrait.fromParse(ParseObject parseObject) {
    return RacialTrait(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
    );
  }
}
