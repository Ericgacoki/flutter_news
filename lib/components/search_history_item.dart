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
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color(0XFFF5ECF4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const SizedBox(width: 4),
              Text(title),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => onTapDelete(title),
                child: const Text("X"),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
