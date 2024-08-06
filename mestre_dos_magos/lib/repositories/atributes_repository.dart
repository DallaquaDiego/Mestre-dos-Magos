import 'dart:developer';
import 'package:mestre_dos_magos/models/attributes.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AttributesRepository {
  Future<ParseObject?> createAttributes(Attributes attributes) async {
    try {
      final parseObject = attributes.toParseObject();
      final response = await parseObject.save();

      if (response.success) {
        return response.results?.first;
      } else {
        log('Erro ao criar Attributes: ${response.error?.message}');
        return null;
      }
    } catch (e, s) {
      log('Repository: Erro ao Criar Atributo!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Criar Atributo');
    }
  }

  Future<bool> updateAttributes(Attributes attributes) async {
    try {
      final parseObject = attributes.toParseObject();
      final response = await parseObject.save();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Editar Atributo!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Editar Atributo');
    }
  }

  Future<bool> deleteAttributes(String attributesId) async {
    try {
      final parseObject = ParseObject('Attributes')..objectId = attributesId;
      final response = await parseObject.delete();

      return response.success;
    } catch (e, s) {
      log('Repository: Erro ao Deletar Atributo!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Deletar Atributo');
    }
  }

  Future<List<Attributes>> getAllAttributes() async {
    try {
      final queryBuilder = QueryBuilder(ParseObject('Attributes'))..orderByAscending('strength');
      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results!.map((at) => Attributes.fromParse(at)).toList();
      } else {
        log('Erro ao buscar Attributes: ${response.error?.message}');
        return [];
      }
    } catch (e, s) {
      log('Repository: Erro ao Buscar Atributos!', error: e.toString(), stackTrace: s);
      return Future.error('Erro ao Buscar Atributos');
    }
  }
}