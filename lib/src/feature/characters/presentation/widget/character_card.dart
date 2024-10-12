import 'package:flutter/material.dart';
import 'package:flutter_devcamp_api/src/feature/characters/presentation/widget/character_image.dart';
import 'package:flutter_devcamp_api/src/feature/characters/presentation/widget/character_overlay.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> films;

  const CharacterCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.films,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 180.0,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          CharacterImage(
            imageUrl,
            radius: 20.0,
            width: double.infinity,
            height: double.infinity,
          ),
          const CharacterOverlay(),
          Positioned(
            bottom: 12.0,
            left: 12.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  films.isNotEmpty ? films.first : '',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
