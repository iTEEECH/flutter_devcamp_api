import 'dart:convert';
import 'dart:io';

import 'package:flutter_devcamp_api/src/data/model/character_model.dart';
import 'package:http/http.dart' as http;

class CharacterRemote {
  Future<List<CharacterModel>> fetchAllCharacters(int page) async {
    // Parameter(s).
    const int pageSize = 10;

    // Path.
    final Uri url = Uri.parse('https://api.disneyapi.dev/character?page=$page&pageSize=$pageSize');

    try {

      // Http call.
      final http.Response response = await http.get(url);

      // Result.
      if (response.statusCode == 200) {
        return (jsonDecode(response.body)['data'] as List)
            .map((character) => CharacterModel.fromMap(character))
            .toList(growable: false);
      }
      return [];
    } on SocketException catch (err) {
      throw Exception(err);
    } catch (err) {
      throw Exception(err);
    }
  }
}
