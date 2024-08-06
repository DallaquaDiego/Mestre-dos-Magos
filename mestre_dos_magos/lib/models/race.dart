import 'package:mestre_dos_magos/models/attributes.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Race {
  Race({
    this.id,
    this.name,
    this.description,
    this.attributeBonus,
  });

  String? id;
  String? name;
  String? description;
  Attributes? attributeBonus;
 

  @override
  String toString() {
    return 'Race{id: $id, name: $name, description: $description, attributeBonus: $attributeBonus}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Race')
      ..objectId = id
      ..set('name', name)
      ..set('description', description)
      ..set('attribute_bonus', attributeBonus?.toParseObject());
    return parseObject;
  }

  factory Race.fromParse(ParseObject parseObject) {
    return Race(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      attributeBonus: parseObject.containsKey('attribute_bonus') && parseObject.get('attribute_bonus') != null
          ? Attributes.fromParse(parseObject.get<ParseObject>('attribute_bonus')!)
          : null,
    );
  }
}
