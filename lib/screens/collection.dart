import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/providers/albums.dart';
import 'package:wanted_vinyls/widgets/album_list.dart';
import 'package:wanted_vinyls/widgets/sorting_bar.dart';

import '../models/album.dart';
import '../models/sorting.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({super.key});

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  late Future<void> _listFuture;
  final _artistSorting = Sorting(asc: true, active: false);
  final _titleSorting = Sorting(asc: true, active: false);
  final _yearSorting = Sorting(asc: true, active: false);

  @override
  void initState() {
    super.initState();
    _listFuture = ref.read(albumsProvider.notifier).loadMyCollection();
  }

  void sortListByArtist(List<Album> list) {
    setState(() {
      if (_artistSorting.asc) {
        list.sort((a, b) => a.artist.compareTo(b.artist));
      } else {
        list.sort((b, a) => a.artist.compareTo(b.artist));
      }
      _artistSorting.asc = !_artistSorting.asc;
    });
  }

  void sortListByTitle(List<Album> list) {
    setState(() {
      if (_titleSorting.asc) {
        list.sort((a, b) => a.title.compareTo(b.title));
      } else {
        list.sort((b, a) => a.title.compareTo(b.title));
      }
      _titleSorting.asc = !_titleSorting.asc;
    });
  }

  void sortListByYear(List<Album> list) {
    setState(() {
      if (_yearSorting.asc) {
        list.sort((a, b) => a.year.compareTo(b.year));
      } else {
        list.sort((b, a) => a.year.compareTo(b.year));
      }
      _yearSorting.asc = !_yearSorting.asc;
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
            SortingBar(
              sortListByArtist: () => sortListByArtist(list),
              sortListByTitle: () => sortListByTitle(list),
              sortListByYear: () => sortListByYear(list),
              sortArtist: _artistSorting,
              sortTitle: _titleSorting,
              sortYear: _yearSorting,
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