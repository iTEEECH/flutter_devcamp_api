import 'package:flutter/material.dart';
import 'package:flutter_devcamp_api/src/data/model/character_model.dart';
import 'package:flutter_devcamp_api/src/data/repository/character_repositroy_impl.dart';
import 'package:flutter_devcamp_api/src/feature/characters/widget/character_card.dart';
import 'package:flutter_devcamp_api/src/feature/characters/widget/character_loading.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<CharacterModel> characters = [];
  bool isLoading = true;

  Future<void> fetchAll() async {
    final repository = CharacterRepositoryImpl();
    final result = await repository.fetchAllCharacters();

    setState(() {
      characters = result;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disney Characters'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: isLoading
              ? const CharacterLoading()
              : ListView.builder(
                  key: UniqueKey(),
                  itemCount: characters.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    final character = characters[index];
                    return CharacterCard(
                      key: ValueKey(index),
                      name: character.name,
                      imageUrl: character.imageUrl,
                      films: character.films,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
