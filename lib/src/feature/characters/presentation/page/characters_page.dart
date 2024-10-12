import 'package:flutter/material.dart';
import 'package:flutter_devcamp_api/src/feature/characters/data/model/character_model.dart';
import 'package:flutter_devcamp_api/src/feature/characters/data/repository/character_repositroy_impl.dart';
import 'package:flutter_devcamp_api/src/feature/characters/presentation/widget/character_card.dart';
import 'package:flutter_devcamp_api/src/feature/characters/presentation/widget/character_loading.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<CharacterModel> characters = [];
  bool isLoading = true;
  bool hasMore = true;
  int page = 1;
  ScrollController controller = ScrollController();

  Future<void> fetchCharacters() async {
    if (!hasMore) return;

    final repository = CharacterRepositoryImpl();
    final result = await repository.fetchAllCharacters(page);

    setState(() {
      characters.addAll(result);
      isLoading = false;
      hasMore = result.length == 10;
      page++;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disney Characters'),
      ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent) {
              fetchCharacters();
            }
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: isLoading
                ? const CharacterLoading()
                : ListView.builder(
              controller: controller,
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
      ),
    );
  }
}