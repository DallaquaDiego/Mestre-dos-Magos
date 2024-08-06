import 'dart:developer';

import 'package:mestre_dos_magos/models/item.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../stores/filter_search_store.dart';

class ItemRepository {
  Future<ParseObject?> createItem(Item item) async {
    try {
      final parseObject = item.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Item: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Item!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Item');
    }
  }

  Future<bool> updateItem(Item item) async {
    try {
      final parseObject = item.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Item!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Item');
    }
  }

  Future<bool> deleteItem(String itemId) async {
    try {
      final parseObject = ParseObject('Item')..objectId = itemId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Item!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Item');
    }
  }

  Future<List<Item>> getAllItems({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('Item'));

    query.includeObject(['category']);
    query.setLimit(limit);
    query.orderByAscending('name');


    if (filterSearchStore != null && filterSearchStore.search.isNotEmpty) {
      query.whereContains('name', filterSearchStore.search);
    }

    try {
      final response = await query.query();
      //print(response.results);

      if (response.success && response.results != null) {
        return response.results!.map((itm) => Item.fromParse(itm)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Itens!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Itens');
    }
  }
}