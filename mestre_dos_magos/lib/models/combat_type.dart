import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CombatType {
  CombatType({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  @override
  String toString() {
    return 'CombatType{id: $id, name: $name}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('CombatType')
      ..objectId = id
      ..set('name', name!);
    return parseObject;
  }

  factory CombatType.fromParse(ParseObject parseObject) {
    return CombatType(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
    );
  }
}
