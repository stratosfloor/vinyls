import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String get apiToken {
  return dotenv.env['DISCOGS_API_TOKEN'] as String;
}

String get discogsUrl {
  return "https://api.discogs.com/database/";
}

void querySearch(String query) async {
  final url = Uri.parse(
      "https://api.discogs.com/database/search?q=$query&type=master&token=$apiToken");
  final response = await http.get(url);
  final resData = json.decode(response.body);
  print(resData['pagination']['items']);
  print(resData['results'][0]['master_url']);
  print(resData['results'][0]['title']);
  print(resData['results'][0]['year'] as String);
  print(resData['results'][0]['thumb']);
  print(resData['results'][0]['cover_image']);
}
