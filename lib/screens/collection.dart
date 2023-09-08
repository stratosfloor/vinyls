import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanted_vinyls/providers/albums.dart';
import 'package:wanted_vinyls/widgets/album_list.dart';

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
    _listFuture = ref.read(albumsProvider.notifier).loadMyCollection();
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Artist'),
                      IconButton(
                        iconSize: 20,
                        onPressed: null,
                        icon: Icon(Icons.arrow_circle_down),
                      ),
                    ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('Title'),
                  IconButton(
                    iconSize: 20,
                    onPressed: null,
                    icon: Icon(Icons.arrow_circle_down),
                  ),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('Year'),
                  IconButton(
                    iconSize: 20,
                    onPressed: null,
                    icon: Icon(Icons.arrow_circle_down),
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