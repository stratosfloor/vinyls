import 'package:uuid/uuid.dart';

var uuid = const Uuid();
// TODO: Add Date addedToCollection

class Album {
  const Album({
    required this.masterId,
    required this.id,
    required this.artist,
    required this.title,
    required this.year,
    required this.thumbnail,
    required this.coverImage,
  });

  final String masterId;
  final String id;
  final String artist;
  final String title;
  final String year;
  final String thumbnail;
  final String coverImage;
}

class ListOfAlbums {
  ListOfAlbums({
    required this.title,
  })  : id = uuid.v4(),
        list = [];
  final String id;
  final String title;
  final List<Album> list;
}
