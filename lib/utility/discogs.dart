import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:wanted_vinyls/models/album.dart';

String get apiToken {
  return dotenv.env['DISCOGS_API_TOKEN'] as String;
}

Future<List<Album>> querySearch(String query) async {
  final url = Uri.parse(
      "https://api.discogs.com/database/search?q=$query&type=master&token=$apiToken");
  final response = await http.get(url);
  final resData = json.decode(response.body);
  final length = resData['pagination']['items'];

  final List<Album> data = [];
  if (length == 0) {
    return data;
  }

  for (var res in resData['results']) {
    final album = Album(
      masterId: res['master_id'].toString(),
      id: res['id'].toString(),
      title: res['title'] ??= '',
      year: res['year'] ??= '',
      thumbnail: res['thumb'] ?? '',
      coverImage: res['cover_image'] ??= '',
    );
    data.add(album);
  }
  return data;
}

Future<List<Album>> getUserCollection(String user) async {
  final url = Uri.parse(
      "https://api.discogs.com/users/$user/collection/folders/0/releases&token=$apiToken");
  final response = await http.get(url);
  final resData = json.decode(response.body);
  final length = resData['pagination']['items'];

  final List<Album> data = [];

  for (var res in resData['releases']) {
    final album = Album(
      masterId: res['master_id'].toString(),
      id: res['id'].toString(),
      title: res['title'] ??= '',
      year: res['year'] ??= '',
      thumbnail: res['thumb'] ?? '',
      coverImage: res['cover_image'] ??= '',
    );
    data.add(album);
  }
  return data;
}

List<Album> createListOfAlbums() {
  return [];
}
