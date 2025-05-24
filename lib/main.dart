// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'data/repository/album_repository.dart';
import 'logic/album_bloc.dart';
import 'presentation/screens/album_list_screen.dart';
import 'presentation/screens/album_detail_screen.dart';

void main() {
  runApp(const AlbumApp());
}

class AlbumApp extends StatelessWidget {
  const AlbumApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AlbumListScreen(),
        ),
        GoRoute(
          path: '/detail/:id',
          builder:
              (context, state) => AlbumDetailScreen(
                albumId: int.parse(state.pathParameters['id']!),
              ),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Albums App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      builder:
          (context, child) => BlocProvider(
            create: (_) => AlbumBloc(AlbumRepository())..add(FetchAlbums()),
            child: child!,
          ),
    );
  }
}
