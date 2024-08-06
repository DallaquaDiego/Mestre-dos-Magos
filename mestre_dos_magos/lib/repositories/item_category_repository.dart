import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../models/item_category.dart';
import '../stores/filter_search_store.dart';

class ItemCategoryRepository {
  Future<ParseObject?> createItemCategory(ItemCategory itemCategory) async {
    try {
      final parseObject = itemCategory.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Categoria: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Categoria!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Categoria');
    }
  }

  Future<bool> updateItemCategory(ItemCategory itemCategory) async {
    try {
      final parseObject = itemCategory.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Categoria!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Categoria');
    }
  }

  Future<bool> deleteItemCategory(String itemCategoryId) async {
    try {
      final parseObject = ParseObject('ItemCategory')..objectId = itemCategoryId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Categoria!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Categoria');
    }
  }

  Future<List<ItemCategory>> getAllItemCategories({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('ItemCategory'));

    query.setLimit(limit);
    query.orderByAscending('name');

    if (filterSearchStore != null && filterSearchStore.search.isNotEmpty) {
      query.whereContains('name', filterSearchStore.search);
    }

    try {
      final response = await query.query();
      //print(response.results);

      if (response.success && response.results != null) {
        return response.results!.map((cat) => ItemCategory.fromParse(cat)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Categorias!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Categorias');
    }
  }
}