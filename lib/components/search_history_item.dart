import 'package:flutter/material.dart';

class SearchHistoryItem extends StatelessWidget {
  const SearchHistoryItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.onTapDelete});

  final String title;
  final Function(String) onTap;
  final Function(String) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(title),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(title),
            const SizedBox(width: 12),
            IconButton(
                onPressed: () => onTapDelete(title), icon: const Text("X")),
            const SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
