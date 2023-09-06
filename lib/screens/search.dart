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
  List _list = [];
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
              return ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(_list[index]['title']),
                  tileColor: index % 2 == 0
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.surface);
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
