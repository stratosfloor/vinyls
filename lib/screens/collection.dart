import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/models/album.dart';
import 'package:wanted_vinyls/providers/albums.dart';
import 'package:wanted_vinyls/utility/discogs.dart';
import 'package:wanted_vinyls/widgets/album_tile.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({super.key});

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  late Future<void> _listFuture;

  @override
  void initState() {
    super.initState();
    _listFuture = ref.read(albumsProvider.notifier).loadAlbums();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(albumsProvider);
    // list.sort((a, b) => a.title.compareTo(b.title));
    return Center(
      child: Scrollbar(
        thickness: 15,
        radius: const Radius.circular(15),
        trackVisibility: false,
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return AlbumTile(
                tile: list[index],
                index: index,
              );
            }),
      ),
    );
  }
}
