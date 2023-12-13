import 'package:flutter/material.dart';
import 'package:news_api/components/search_history_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchParam = "";
  final TextEditingController searchInputController = TextEditingController();
  List<String> recentSearches = [
    "Latest",
    "Happening now",
    "Israel war",
    "Dummy"
  ];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // TODO: Uncomment this
            // Navigator.pop(context);
          },
        ),
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar,
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: searchInputController,
              onSubmitted: (value) {
                // TODO: Perform Search
                setState(() {
                  recentSearches.contains(value)
                      ? null
                      : recentSearches.add(value);
                });
              },
              decoration: const InputDecoration(
                  hintText: "Search news",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  filled: true),
            ),

            const SizedBox(height: 12),

            const Text(
              "Recently Searched",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 12),

            // Search History Items
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: recentSearches.map((item) {
                return SearchHistoryItem(
                  title: item,
                  onTap: (title) {
                    setState(() {
                      searchInputController.text = title;
                      // TODO: Perform Search
                    });
                  },
                  onTapDelete: (title) {
                    // TODO: delete this recently searched item
                    setState(() {
                      recentSearches.remove(title);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Clear History Button
            GestureDetector(
              onTap: () => {
                // TODO: Clear recent searches
                setState(() {
                  recentSearches.clear();
                })
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF453944).withOpacity(.24),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: const Text(
                      "Clear All",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
