import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../models/player.dart';
import '../stores/filter_search_store.dart';

class PlayerRepository {
  Future<ParseObject?> createPlayer(Player player) async {
    try {
      final parseObject = player.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Player: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Player!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Player');
    }
  }

  Future<bool> updatePlayer(Player player) async {
    try {
      final parseObject = player.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Player!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Player');
    }
  }

  Future<bool> deletePlayer(String playerId) async {
    try {
      final parseObject = ParseObject('Player')..objectId = playerId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Player!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Player');
    }
  }

  Future<List<Player>> getAllPlayers({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('Player'));

    query.includeObject(['class', 'class.combat_type', 'race', 'race.racial_trait', 'sub_race', 'sub_race.parent_race', 'sub_race.parent_race.racial_trait', 'sub_race.sub_racial_trait', 'itens', 'spells']);
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
        final players = response.results!.map((pl) => Player.fromParse(pl)).toList();
        return players;
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Players!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Players');
    }
  }
}
