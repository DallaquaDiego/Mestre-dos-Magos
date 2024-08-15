import 'dart:developer';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../models/combat_type.dart';
import '../stores/filter_search_store.dart';

class CombatTypeRepository {
  Future<List<CombatType>> getAllCombatTypes({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('CombatType'));
    query.orderByAscending('name');

    if (page != null && page > 0) {
      final int skip = (page - 1) * limit;
      query.setAmountToSkip(skip);
      query.setLimit(limit);
    }

    if (filterSearchStore!.search != '') {
      query.whereContains('name', filterSearchStore.search);
    }

    try {
      final response = await query.query();

      if (response.success && response.results != null) {
        return response.results!.map((at) => CombatType.fromParse(at)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Tipos de Combate!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Tipos de Combate');
    }
  }
}