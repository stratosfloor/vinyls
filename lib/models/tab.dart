import 'package:flutter/material.dart';

class Tab {
  Tab({required this.title, required this.icon});
  final String title;
  final Icon icon;
}

List<Tab> menuTabs = [
  Tab(title: 'Main', icon: const Icon(Icons.home)),
  Tab(title: 'Collec', icon: const Icon(Icons.library_music)),
  Tab(title: 'Search', icon: const Icon(Icons.search)),
  Tab(title: 'Lists', icon: const Icon(Icons.list)),
];
