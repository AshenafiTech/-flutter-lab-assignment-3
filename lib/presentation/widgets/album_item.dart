import 'package:flutter/material.dart';
import '../../data/models/album_model.dart';

class AlbumItem extends StatelessWidget {
  final Album album;
  final String thumbnailUrl;
  final bool isLocal;

  const AlbumItem({
    super.key,
    required this.album,
    required this.thumbnailUrl,
    this.isLocal = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isLocal
          ? Image.asset(thumbnailUrl, width: 50, height: 50, fit: BoxFit.cover)
          : Image.network(thumbnailUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(album.title),
      onTap: () {
        // navigate to detail screen using GoRouter or Navigator
      },
    );
  }
}
