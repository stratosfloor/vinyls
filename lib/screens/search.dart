import 'package:flutter/material.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:wanted_vinyls/widgets/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _query;

  void search(String query) {
    setState(() {
      _query = query;
    });
    // querySearch(query);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('No search');
    if (_query == '') {
      content = const Text('Empty string');
    }
    // _query.isNull ? const Text('NO SEACRH FOUND') : const Text('WE HAVE DATA');

    return Column(
      children: [
        Search(
          onSearch: (query) {
            search(query);
          },
        ),
        Expanded(
          child: Center(
            child: content,
          ),
        ),
      ],
    );
  }
}
