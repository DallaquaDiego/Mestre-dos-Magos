import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../models/racial_trait.dart';
import '../stores/filter_search_store.dart';

class RacialTraitRepository {
  Future<ParseObject?> createRacialTrait(RacialTrait racialTrait) async {
    try {
      final parseObject = racialTrait.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Traço Racial: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Traço Racial!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Traço Racial');
    }
  }

  Future<bool> updateRacialTrait(RacialTrait racialTrait) async {
    try {
      final parseObject = racialTrait.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Traço Racial!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Traço Racial');
    }
  }

  Future<bool> deleteRacialTrait(String racialTraitId) async {
    try {
      final parseObject = ParseObject('RacialTraits')..objectId = racialTraitId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Traço Racial!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Traço Racial');
    }
  }
  
  Future<List<RacialTrait>> getAllRacialTraits({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('RacialTraits'));

    query.setLimit(limit);
    query.orderByAscending('name');

    if (filterSearchStore != null && filterSearchStore.search.isNotEmpty) {
      query.whereContains('name', filterSearchStore.search);
    }

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