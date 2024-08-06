import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ItemCategory {
  ItemCategory({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  @override
  String toString() {
    return 'ItemCategory{id: $id, name: $name}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('ItemCategory')
      ..objectId = id
      ..set('name', name!);
    return parseObject;
  }

  factory ItemCategory.fromParse(ParseObject parseObject) {
    return ItemCategory(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
    );
  }
}
