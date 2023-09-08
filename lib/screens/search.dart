import 'package:flutter/material.dart';
import 'package:wanted_vinyls/models/album.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:wanted_vinyls/widgets/album_list.dart';
import 'package:wanted_vinyls/widgets/search.dart';

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
    Widget content = const Center(child: Text('No search'));
    if (_query != null) {
      content = const Center(child: Text('No albums found'));
    }
    if (_list.isNotEmpty) {
      content = AlbumList(
        list: _list,
        addWidget: true,
      );
    }

    return Column(
      children: [
        Search(
          onSearch: (query) {
            search(query);
          },
        ),
        Expanded(
          child: !_isSearching
              ? content
              : const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
