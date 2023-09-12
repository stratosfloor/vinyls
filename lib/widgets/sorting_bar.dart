import 'package:flutter/material.dart';
import '../models/sorting.dart';

class SortingBar extends StatefulWidget {
  const SortingBar({
    super.key,
    required this.sortListByArtist,
    required this.sortListByTitle,
    required this.sortListByYear,
    required this.sortArtist,
    required this.sortTitle,
    required this.sortYear,
  });

  final void Function() sortListByArtist;
  final void Function() sortListByTitle;
  final void Function() sortListByYear;
  final Sorting sortArtist;
  final Sorting sortTitle;
  final Sorting sortYear;

  @override
  State<SortingBar> createState() => _SortingBarState();
}

class _SortingBarState extends State<SortingBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                  widget.sortListByArtist();
                  setState(() {
                    widget.sortArtist.active = true;
                    widget.sortTitle.active = false;
                    widget.sortYear.active = false;
                  });
                },
                icon: widget.sortArtist.asc
                    ? const Icon(Icons.arrow_circle_up)
                    : const Icon(Icons.arrow_circle_down),
                color: widget.sortArtist.active
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onBackground,
              ),
            ]),
        Row(mainAxisSize: MainAxisSize.min, children: [
          const Text('Title'),
          IconButton(
            iconSize: 20,
            onPressed: () {
              widget.sortListByTitle();
              setState(() {
                widget.sortArtist.active = false;
                widget.sortTitle.active = true;
                widget.sortYear.active = false;
              });
            },
            icon: widget.sortTitle.asc
                ? const Icon(Icons.arrow_circle_up)
                : const Icon(Icons.arrow_circle_down),
            color: widget.sortTitle.active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onBackground,
          ),
        ]),
        Row(mainAxisSize: MainAxisSize.min, children: [
          const Text('Year'),
          IconButton(
            iconSize: 20,
            onPressed: () {
              widget.sortListByYear();
              setState(() {
                widget.sortArtist.active = false;
                widget.sortTitle.active = false;
                widget.sortYear.active = true;
              });
            },
            icon: widget.sortYear.asc
                ? const Icon(Icons.arrow_circle_up)
                : const Icon(Icons.arrow_circle_down),
            color: widget.sortYear.active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onBackground,
          ),
        ]),
      ],
    );
  }
}
