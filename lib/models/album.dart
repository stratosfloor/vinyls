import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Album {
  const Album({
    required this.masterId,
    required this.title,
    required this.year,
    required this.genre,
    required this.thumbnail,
    required this.coverImage,
  });

  final int masterId;
  final String title;
  final String year;
  final String genre;
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
