import 'dart:developer';

import 'package:mestre_dos_magos/models/spell.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SpellRepository {
  Future<ParseObject?> createSpell(Spell spell) async {
    try {
      final parseObject = spell.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Magia: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Magia');
    }
  }

  Future<bool> updateSpell(Spell spell) async {
    try {
      final parseObject = spell.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Magia');
    }
  }

  Future<bool> deleteSpell(String spellId) async {
    try {
      final parseObject = ParseObject('Spell')..objectId = spellId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Magia');
    }
  }

  Future<List<Spell>> getAllSpells() async {
    try {
      final query = QueryBuilder(ParseObject('Spell'));
      final response = await query.query();

      if (response.success && response.results != null) {
        return response.results!.map((at) => Spell.fromParse(at)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Magia!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Magia');
    }
  }
}