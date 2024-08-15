import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';


import '../../models/spell_category.dart';
import '../stores/filter_search_store.dart';

class SpellCategoryRepository {
  Future<ParseObject?> createSpellCategory(SpellCategory spellCategory) async {
    try {
      final parseObject = spellCategory.toParseObject();
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

  Future<bool> updateSpellCategory(SpellCategory spellCategory) async {
    try {
      final parseObject = spellCategory.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Categoria!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Categoria');
    }
  }

  Future<bool> deleteSpellCategory(String spellCategoryId) async {
    try {
      final parseObject = ParseObject('SpellCategory')..objectId = spellCategoryId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Categoria!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Categoria');
    }
  }

  Future<List<SpellCategory>> getAllISpellCategories({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('SpellCategory'));

    query.orderByAscending('name');

    if (page != null && page > 0) {
      final int skip = (page - 1) * limit;
      query.setAmountToSkip(skip);
      query.setLimit(limit);
    }

    if (filterSearchStore != null && filterSearchStore.search.isNotEmpty) {
      query.whereContains('name', filterSearchStore.search);
    }

    try {
      final response = await query.query();
      //print(response.results);

      if (response.success && response.results != null) {
        return response.results!.map((cat) => SpellCategory.fromParse(cat)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Categorias!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Categorias');
    }
  }
}