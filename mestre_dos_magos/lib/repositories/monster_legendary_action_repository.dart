import 'dart:developer';

import 'package:mestre_dos_magos/models/monster_legendary_action.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../stores/filter_search_store.dart';

class MonsterLegendaryActionRepository {
  Future<List<MonsterLegendaryAction>> getAllLegendaryActions({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('MonsterLegendaryAction'));

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
        final legendaryActions = response.results!.map((legendaryAction) => MonsterLegendaryAction.fromParse(legendaryAction)).toList();
        return legendaryActions;
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Ações Lendárias!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Ações Lendárias');
    }
  }
}
