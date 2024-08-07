import 'dart:developer';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../models/sub_race.dart';
import '../stores/filter_search_store.dart';

class SubRaceRepository {
  Future<ParseObject?> createSubRace(SubRace subRace) async {
    try {
      final parseObject = subRace.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Sub-Raça: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Sub-Raça!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Sub-Raça');
    }
  }

  Future<bool> updateSubRace(SubRace subRace) async {
    try {
      final parseObject = subRace.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Sub-Raça!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Sub-Raça');
    }
  }

  Future<bool> deleteSubRace(String subRaceId) async {
    try {
      final parseObject = ParseObject('SubRace')..objectId = subRaceId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Sub-Raça!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Sub-Raça');
    }
  }

  Future<List<SubRace>> getAllSubRaces({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('SubRace'));

    query.includeObject(['parent_race', 'racial_traits']);
    query.setLimit(limit);
    query.orderByAscending('name');

    if (filterSearchStore != null && filterSearchStore.search.isNotEmpty) {
      query.whereContains('name', filterSearchStore.search);
    }

    try {
      final response = await query.query();
      //print('GET Sub-Races : ${response.results}');

      if (response.success && response.results != null) {
        return response.results!.map((sbrc) => SubRace.fromParse(sbrc)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Sub-Raças!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Sub-Raças');
    }
  }
}