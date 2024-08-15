import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../models/monster.dart';
import '../stores/filter_search_store.dart';

class MonsterRepository {
  Future<ParseObject?> createMonster(Monster monster) async {
    try {
      final parseObject = monster.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Monstro: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Monstro!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Monstro');
    }
  }

  Future<bool> updateMonster(Monster monster) async {
    try {
      final parseObject = monster.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Monstro!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Monstro');
    }
  }

  Future<bool> deleteMonster(String monsterId) async {
    try {
      final parseObject = ParseObject('Monster')..objectId = monsterId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Monstro!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Monstro');
    }
  }

  Future<List<Monster>> getAllMonsters({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('Monster'));

    query.includeObject(['skills', 'actions', 'legendary_actions']);
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
        final monsters = response.results!.map((monster) => Monster.fromParse(monster)).toList();
        return monsters;
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Monstros!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Monstros');
    }
  }
}
