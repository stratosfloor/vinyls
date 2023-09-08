import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/models/album.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:http/http.dart' as http;

class AlbumsNotifier extends StateNotifier<List<Album>> {
  AlbumsNotifier() : super(const []);

  // TODO: Rename to loadCollection
  Future<void> loadAlbums() async {
    String endpoint = collectionEndpoint;

    final response = await http.get(Uri.parse(endpoint));
    final resData = json.decode(response.body);

    final List<Album> data = [];

    if (resData['releases'] == []) {
      state = data;
    }

    for (var res in resData['releases']) {
      final album = Album(
        masterId: res['master_id'].toString(),
        id: res['id'].toString(),
        artist: res['basic_information']['artists'][0]
            ['name'], //TODO: artists is an array, this only takes first name
        title: res['basic_information']['title'],
        year: res['basic_information']['year'].toString(),
        thumbnail: res['basic_information']['thumb'] ?? '',
        coverImage: res['basic_information']['cover_image'] ??= '',
      );
      data.add(album);
    }
    state = data;
  }

  // TODO: move querysearch from discogs to here and add provider on searchscreen
  // Future<void> quearySearch
}

final albumsProvider = StateNotifierProvider<AlbumsNotifier, List<Album>>(
  (ref) => AlbumsNotifier(),
);
