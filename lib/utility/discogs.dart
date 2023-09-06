import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:wanted_vinyls/models/album.dart';

String get apiToken {
  return dotenv.env['DISCOGS_API_TOKEN'] as String;
}

String get discogsUrl {
  return "https://api.discogs.com/database/";
}

Future<List> querySearch(String query) async {
  final url = Uri.parse(
      "https://api.discogs.com/database/search?q=$query&type=master&token=$apiToken");
  final response = await http.get(url);
  final resData = json.decode(response.body);
  final length = resData['pagination']['items'];

  if (length == 0) {
    return [];
  }

  return resData['results'];
}
