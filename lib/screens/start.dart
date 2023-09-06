import 'package:flutter/material.dart';
import 'package:wanted_vinyls/screens/lists.dart';
import 'package:wanted_vinyls/screens/main.dart';
import 'package:wanted_vinyls/screens/search.dart';

const tabs = ['Main', 'Search', 'Lists'];

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wanted Vinyls'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4,
          shadowColor: Theme.of(context).colorScheme.surface,
          bottom: TabBar(
            tabs: <Widget>[for (var tab in tabs) Tab(text: tab)],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MainScreen(),
            SearchScreen(),
            ListsScreen(),
          ],
        ),
      ),
    );
  }
}
