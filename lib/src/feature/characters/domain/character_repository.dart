import 'package:flutter_devcamp_api/src/feature/characters/data/model/character_model.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> fetchAllCharacters(int page);
}