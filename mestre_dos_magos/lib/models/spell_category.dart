import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SpellCategory {
  SpellCategory({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  @override
  String toString() {
    return 'SpellCategory{id: $id, name: $name}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('SpellCategory')
      ..objectId = id
      ..set('name', name!);
    return parseObject;
  }

  factory SpellCategory.fromParse(ParseObject parseObject) {
    return SpellCategory(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
    );
  }
}
