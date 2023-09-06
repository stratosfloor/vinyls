import 'package:flutter_dotenv/flutter_dotenv.dart';

String get apiToken {
  return dotenv.env['DISCOGS_API_TOKEN'] as String;
}
