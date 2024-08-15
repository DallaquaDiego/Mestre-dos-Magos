import 'dart:developer';

import 'package:mestre_dos_magos/models/spell.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../stores/filter_search_store.dart';

class SpellRepository {
  Future<ParseObject?> createSpell(Spell spell) async {
    try {
      final parseObject = spell.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Magia: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Magia');
    }
  }

  Future<bool> updateSpell(Spell spell) async {
    try {
      final parseObject = spell.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Magia');
    }
  }

  Future<bool> deleteSpell(String spellId) async {
    try {
      final parseObject = ParseObject('Spell')..objectId = spellId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Magia');
    }
  }

  Future<List<Spell>> getAllSpells({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('Spell'));

    query.includeObject(['category']);
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
        return response.results!.map((at) => Spell.fromParse(at)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Magia');
    }
  }
}