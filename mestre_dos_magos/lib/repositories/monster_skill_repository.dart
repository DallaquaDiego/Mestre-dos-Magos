import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/monster_skill.dart';
import '../stores/filter_search_store.dart';

class MonsterSkillRepository {
  Future<List<MonsterSkill>> getAllSkills({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('MonsterSkill'));

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
        final monsters = response.results!.map((skill) => MonsterSkill.fromParse(skill)).toList();
        return monsters;
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Habilidades do Monstro!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Habilidades do Monstro');
    }
  }
}
