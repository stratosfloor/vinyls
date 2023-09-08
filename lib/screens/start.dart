import 'package:flutter/material.dart';
import 'package:wanted_vinyls/models/tab.dart';
import 'package:wanted_vinyls/screens/collection.dart';
import 'package:wanted_vinyls/screens/lists.dart';
import 'package:wanted_vinyls/screens/main.dart';
import 'package:wanted_vinyls/screens/search.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  // TODO: add darkmode, stateful widget

  @override
  build(BuildContext context) {
    return DefaultTabController(
      length: menuTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wanted Vinyls'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode))],
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4,
          shadowColor: Theme.of(context).colorScheme.surface,
          bottom: TabBar(
            tabs: <Widget>[
              for (var tab in menuTabs)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    tab.icon,
                    // Text(tab.title),
                  ],
                ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MainScreen(),
            CollectionScreen(),
            SearchScreen(),
            ListsScreen(),
          ],
        ),
      ),
    );
  }
}
