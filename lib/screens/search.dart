import 'package:flutter/material.dart';
import 'package:wanted_vinyls/models/album.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:wanted_vinyls/widgets/search.dart';
import 'package:wanted_vinyls/widgets/search_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _query;
  List<Album> _list = [];
  var _isSearching = false;

  void search(String query) async {
    setState(() {
      _query = query;
      _isSearching = true;
    });
    final data = await querySearch(query);

    setState(() {
      _list = data;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('No search');
    if (_query != null) {
      content = const Text('No albums found');
    }
    if (_list.isNotEmpty) {
      content = Scrollbar(
        thickness: 15,
        radius: const Radius.circular(15),
        trackVisibility: false,
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return SearchTile(tile: _list[index], index: index);
            }),
      );
    }

    return Column(
      children: [
        Search(
          isSearching: _isSearching,
          onSearch: (query) {
            search(query);
          },
        ),
        Expanded(
          child: Container(
            child: content,
          ),
        ),
      ],
    );
  }
}
