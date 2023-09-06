import 'package:flutter/material.dart';
import 'package:wanted_vinyls/screens/widgets/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Search(),
        Expanded(
          child: Center(
            child: Text('CENTER'),
          ),
        ),
      ],
    );
  }
}
