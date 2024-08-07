import 'package:mestre_dos_magos/models/item_category.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Item {
  Item({
    this.id,
    this.name,
    this.description,
    this.damage,
    this.price,
    this.effect,
    this.item_category,
  });

  String? id;
  String? name;
  String? description;
  String? damage;
  int? price;
  String? effect;
  ItemCategory? item_category;

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description, damage: $damage, price: $price, effect:$effect, item_category: $item_category}';
  }

  ParseObject toParseObject() {
    final parseObject = ParseObject('Item')
      ..objectId = id
      ..set('name', name!)
      ..set('description', description!)
      ..set('price', price!)
      ..set('category', item_category!.toParseObject())
      ..set('effect', effect)
      ..set('damage', damage);
    return parseObject;
  }

  factory Item.fromParse(ParseObject parseObject) {
    return Item(
      id: parseObject.objectId,
      name: parseObject.get<String>('name'),
      description: parseObject.get<String>('description'),
      price: parseObject.get<int>('price'),
      damage: parseObject.get<String>('damage'),
      effect: parseObject.get<String>('effect'),
      item_category: parseObject.containsKey('category') && parseObject.get<ParseObject>('category') != null
          ? ItemCategory.fromParse(parseObject.get<ParseObject>('category')!)
          : null,
    );
  }
}
