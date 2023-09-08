import 'package:flutter/material.dart';

import '../models/album.dart';
import 'add_album.dart';
import 'album_tile.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({
    super.key,
    required this.list,
    this.addWidget = false,
  });

  final List<Album> list;
  final bool addWidget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return AlbumTile(
            tile: list[index],
            index: index,
            addToList: addWidget ? const AddAlbum() : null,
          );
        });
  }
}
