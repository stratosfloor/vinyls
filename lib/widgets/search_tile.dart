import 'package:flutter/material.dart';
import 'package:wanted_vinyls/models/album.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
    required this.tile,
    required this.index,
  });

  final Album tile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(tile.thumbnail),
          fit: BoxFit.contain,
        )),
      ),
      title: Text(tile.title),
      tileColor: index % 2 == 0
          ? Theme.of(context).colorScheme.secondaryContainer
          : Theme.of(context).colorScheme.surface,
      trailing: const Icon(Icons.add),
    );
  }
}
