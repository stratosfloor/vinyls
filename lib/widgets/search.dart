import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wanted_vinyls/utility/discogs.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();

  void onSearch() {
    print(apiToken);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            icon: const Icon(
              Icons.search,
            ),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
