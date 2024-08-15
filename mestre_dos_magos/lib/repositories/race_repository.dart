import 'dart:developer';

import 'package:mestre_dos_magos/models/race.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../stores/filter_search_store.dart';

class RaceRepository {
  Future<ParseObject?> createRace(Race race) async {
    try {
      final parseObject = race.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Raça: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Raça!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Raça');
    }
  }

  Future<bool> updateRace(Race race) async {
    try {
      final parseObject = race.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Raça!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Raça');
    }
  }

  Future<bool> deleteRace(String raceId) async {
    try {
      final parseObject = ParseObject('Race')..objectId = raceId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Raça!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Raça');
    }
  }

  Future<List<Race>> getAllRaces({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('Race'));

    query.includeObject(['racial_trait']);
    query.setLimit(limit);
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
      //print('GET Races : ${response.results}');

      if (response.success && response.results != null) {
        return response.results!.map((rc) => Race.fromParse(rc)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Raças!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Raças');
    }
  }
}