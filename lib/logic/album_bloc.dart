// lib/logic/album_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/album_model.dart';
import '../data/models/photo_model.dart';
import '../data/repository/album_repository.dart';

abstract class AlbumEvent {}
class FetchAlbums extends AlbumEvent {}

abstract class AlbumState {}
class AlbumInitial extends AlbumState {}
class AlbumLoading extends AlbumState {}
class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final List<Photo> photos;
  AlbumLoaded(this.albums, this.photos);
}
class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc(this.repository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        final photos = await repository.fetchPhotos();
        emit(AlbumLoaded(albums, photos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
