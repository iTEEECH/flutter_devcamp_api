import 'package:flutter_devcamp_api/src/data/model/character_model.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> fetchAllCharacters(int page);
}