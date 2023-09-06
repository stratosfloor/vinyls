import 'package:flutter/material.dart';
import 'package:wanted_vinyls/utility/discogs.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    required this.onSearch,
    required this.isSearching,
  });

  final void Function(String query) onSearch;
  final bool isSearching;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 14,
          top: 14,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: false,
                controller: _searchController,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                enableSuggestions: true,
                decoration: InputDecoration(
                  fillColor: Colors.amber,
                  hintText: 'Search for album',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              color: Theme.of(context).colorScheme.onBackground,
              icon: widget.isSearching
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.search),
              onPressed: () {
                if (_searchController.text == '') {
                  return;
                }
                widget.onSearch(_searchController.text);
                FocusScope.of(context).unfocus();
                _searchController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
