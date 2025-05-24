// lib/presentation/screens/album_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/album_bloc.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album #$albumId')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            final album = state.albums.firstWhere((a) => a.id == albumId);
            final photos =
                state.photos.where((p) => p.albumId == albumId).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  album.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < photos.length; i += 2)
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Placeholder(
                              fallbackWidth: 180,
                              fallbackHeight: 180,
                            ),
                            Text(
                              photos[i].id.toString(),
                              style: TextStyle(fontSize: 24),
                            ),
                            Text(
                              photos[i].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (i + 1 < photos.length)
                        Expanded(
                          child: Column(
                            children: [
                              const Placeholder(
                                fallbackWidth: 180,
                                fallbackHeight: 180,
                              ),
                              Text(
                                photos[i + 1].id.toString(),
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                photos[i + 1].title,
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      else
                        const Expanded(
                          child: SizedBox(),
                        ),
                    ],
                  ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
