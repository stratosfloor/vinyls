import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/models/album.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:http/http.dart' as http;

class AlbumsNotifier extends StateNotifier<List<Album>> {
  AlbumsNotifier() : super(const []);

  Future<void> loadAlbums() async {
    final token = dotenv.env['DISCOGS_API_TOKEN'];
    final name = dotenv.env['DISCOGS_USERNAME'];

    String endpoint =
        'https://api.discogs.com/users/$name/collection/folders/0/releases?token=$token';

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
        title: res['basic_information']['artists'][0]['name'] +
            ' - ' +
            res['basic_information']['title'],
        year: res['basic_information']['year'].toString(),
        thumbnail: res['basic_information']['thumb'] ?? '',
        coverImage: res['basic_information']['cover_image'] ??= '',
      );
      data.add(album);
    }
    state = data;
  }
}

final albumsProvider = StateNotifierProvider<AlbumsNotifier, List<Album>>(
  (ref) => AlbumsNotifier(),
);
