import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../models/racial_trait.dart';
import '../stores/filter_search_store.dart';

class RacialTraitRepository {
  Future<List<RacialTrait>> getAllRacialTraits({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('RacialTraits'));

    query.setLimit(limit);
    query.orderByAscending('name');

    try {
      final response = await query.query();
      //print(response.results);

      if (response.success && response.results != null) {
        return response.results!.map((rc) => RacialTrait.fromParse(rc)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Traços Raciais!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Traços Raciais');
    }
  }
}