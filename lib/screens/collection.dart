import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/providers/albums.dart';
import 'package:wanted_vinyls/widgets/album_list.dart';

import '../models/album.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({super.key});

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  late Future<void> _listFuture;
  bool _artistAscending = true;
  bool _titleAscending = true;
  bool _yearAscending = true;

  @override
  void initState() {
    super.initState();
    _listFuture = ref.read(albumsProvider.notifier).loadMyCollection();
  }

  void sortListByArtist(List<Album> list) {
    setState(() {
      if (_artistAscending) {
        list.sort((a, b) => a.artist.compareTo(b.artist));
      } else {
        list.sort((b, a) => a.artist.compareTo(b.artist));
      }
      _artistAscending = !_artistAscending;
    });
  }

  void sortListByTitle(List<Album> list) {
    setState(() {
      if (_titleAscending) {
        list.sort((a, b) => a.title.compareTo(b.title));
      } else {
        list.sort((b, a) => a.title.compareTo(b.title));
      }
      _titleAscending = !_titleAscending;
    });
  }

  void sortListByYear(List<Album> list) {
    setState(() {
      if (_yearAscending) {
        list.sort((a, b) => a.year.compareTo(b.year));
      } else {
        list.sort((b, a) => a.year.compareTo(b.year));
      }
      _yearAscending = !_yearAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = ref.watch(albumsProvider);
    // list.sort((a, b) => a.title.compareTo(b.title));

    return Center(
      child: Scrollbar(
        thickness: 15,
        radius: const Radius.circular(15),
        trackVisibility: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Artist'),
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          sortListByArtist(list);
                        },
                        icon: const Icon(Icons.arrow_circle_down),
                      ),
                    ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Title'),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      sortListByTitle(list);
                    },
                    icon: const Icon(Icons.arrow_circle_down),
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Year'),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      sortListByYear(list);
                    },
                    icon: const Icon(Icons.arrow_circle_down),
                  ),
                ]),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: _listFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : AlbumList(
                            list: list,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: sorteting, filtering and search in collection