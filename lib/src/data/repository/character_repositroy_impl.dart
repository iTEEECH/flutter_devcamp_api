import 'package:flutter_devcamp_api/src/data/model/character_model.dart';
import 'package:flutter_devcamp_api/src/data/remote/character_remote.dart';
import 'package:flutter_devcamp_api/src/domain/character_repository.dart';

class CharacterRepositoryImpl extends CharacterRepository {
  @override
  Future<List<CharacterModel>> fetchAllCharacters(int page) async {
    try {
      // Remote call.
      final CharacterRemote remote = CharacterRemote();
      final List<CharacterModel> characters = await remote.fetchAllCharacters(page);

      // Result.
      return characters;
    } catch (err) {
      throw Exception(err);
    }
  }
}