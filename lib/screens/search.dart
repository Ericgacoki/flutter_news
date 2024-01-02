import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/search_history_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchParam = "";
  final TextEditingController searchInputController = TextEditingController();
  List<String> recentSearches = [
    "Breaking News",
    "Tech",
    "Climate",
    "Global Economy",
    "Sports Highlights",
    "Space",
    "Cultural Events"
  ];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: searchInputController,
              onSubmitted: (value) {
                // TODO: Perform Search
                if (value.trim().isNotEmpty) {
                  String trimmedValue = value.trim();
                  setState(() {
                    recentSearches.contains(trimmedValue)
                        ? null
                        : recentSearches.add(trimmedValue);
                  });
                }
              },
              decoration: InputDecoration(
                hintText: "Search news",
                hintStyle: const TextStyle(fontSize: 16),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                filled: true,
                suffixIcon: Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          // TODO: Perform Search
                          if (searchInputController.value.text
                              .trim()
                              .isNotEmpty) {
                            setState(() {
                              recentSearches.contains(
                                      searchInputController.value.text)
                                  ? null
                                  : recentSearches
                                      .add(searchInputController.value.text);
                            });
                          }
                        },
                        icon: SvgPicture.asset('assets/icons/search.svg')),
                    const SizedBox(width: 8)
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Recently Searched",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            // Search History Items
            Wrap(
              spacing: 12,
              runSpacing: 12,
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
                        color: const Color(0xFF453944).withOpacity(.05),
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
