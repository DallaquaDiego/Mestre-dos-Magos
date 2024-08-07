import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../models/player.dart';

class PlayerRepository {
  Future<ParseObject?> createPlayer(Player player) async {
    try {
      final parseObject = player.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Attributes: ${response.error?.message}');
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

  Future<List<Player>> getAllPlayers() async {
    try {
      final query = QueryBuilder(ParseObject('Player'));
      final response = await query.query();

      if (response.success && response.results != null) {
        return response.results!.map((pl) => Player.fromParse(pl)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Players!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Players');
    }
  }
}
