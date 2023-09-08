import 'package:flutter/material.dart';

import '../models/album.dart';
import 'add_album.dart';
import 'album_tile.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({
    super.key,
    required this.list,
  });

  final List<Album> list;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 15,
      radius: const Radius.circular(15),
      trackVisibility: false,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return AlbumTile(
              tile: list[index],
              index: index,
              addToList: const AddAlbum(),
            );
          }),
    );
  }
}
