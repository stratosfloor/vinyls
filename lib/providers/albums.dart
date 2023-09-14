import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/models/album.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:http/http.dart' as http;

class AlbumsNotifier extends StateNotifier<List<Album>> {
  AlbumsNotifier() : super(const []);

  Future<void> loadMyCollection() async {
    final resData = await loadData();

    final int pages = resData['pagination']['pages'];
    final List<Album> data = [];

    if (resData['releases'] == []) {
      state = data;
    }

    for (var res in resData['releases']) {
      final album = createAlbum(res);
      data.add(album);
    }
    if (pages > 1) {
      for (int i = 2; i <= pages; i++) {
        final resData = await loadData(page: i);
        for (var res in resData['releases']) {
          final album = createAlbum(res);
          data.add(album);
        }
      }
    }
    state = data;
  }

  dynamic loadData({int page = 1}) async {
    String endpoint = collectionEndpoint(page: page);
    final response = await http.get(Uri.parse(endpoint));
    final resData = json.decode(response.body);
    return resData;
  }

  Album createAlbum(dynamic data) {
    return Album(
      masterId: data['master_id'].toString(),
      id: data['id'].toString(),
      artist: data['basic_information']['artists'][0]
          ['name'], //TODO: artists is an array, this only takes first name
      title: data['basic_information']['title'],
      year: data['basic_information']['year'].toString(),
      thumbnail: data['basic_information']['thumb'] ?? '',
      coverImage: data['basic_information']['cover_image'] ??= '',
    );
  }

  // TODO: move querysearch from discogs to here and add provider on searchscreen
  // Future<void> quearySearch
}

final albumsProvider = StateNotifierProvider<AlbumsNotifier, List<Album>>(
  (ref) => AlbumsNotifier(),
);
