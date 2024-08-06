import 'dart:developer';

import 'package:mestre_dos_magos/models/class.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../stores/filter_search_store.dart';

class ClassRepository {
  Future<ParseObject?> createClass(Class classe) async {
    try {
      final parseObject = classe.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Classe: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Classe!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Classe');
    }
  }

  Future<bool> updateClass(Class classe) async {
    try {
      final parseObject = classe.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Classe!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Classe');
    }
  }

  Future<bool> deleteClass(String classId) async {
    try {
      final parseObject = ParseObject('Class')..objectId = classId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Classe!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Classe');
    }
  }

  Future<List<Class>> getAllClasses({int? page, int limit = 15, FilterSearchStore? filterSearchStore}) async {
    final query = QueryBuilder(ParseObject('Class'));

    query.includeObject(['combat_type']);
    query.setLimit(limit);
    query.orderByAscending('name');


    if (filterSearchStore != null && filterSearchStore.search.isNotEmpty) {
      query.whereContains('name', filterSearchStore.search);
    }

    try {
      final response = await query.query();
      //print(response.results);

      if (response.success && response.results != null) {
        return response.results!.map((at) => Class.fromParse(at)).toList();
      } else {
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Classes!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Classes');
    }
  }
}