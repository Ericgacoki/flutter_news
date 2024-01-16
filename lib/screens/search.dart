import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/api_key.dart';
import 'package:news_api/util/constants.dart';

import '../model/article.dart';
import '../widgets/article_item.dart';
import '../widgets/search_history_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchInputController = TextEditingController();
  Future<List<Article>?>? _futureSearchResult;

  void _performSearch(String params) {
    FocusScope.of(context).unfocus();
    _futureSearchResult = searchArticles(params);
  }

  Future<List<Article>> searchArticles(String params) async {
    final url = "$BASE_URL/everything?q=$params&apiKey=$api_key";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        List<Article> articles = List.from(data['articles'])
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Status code ${response.statusCode}');
      }
    } else {
      throw Exception('Failed to load articles');
    }
  }

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
                if (value.trim().isNotEmpty) {
                  _performSearch(value);
                }

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
                          if (searchInputController.value.text
                              .trim()
                              .isNotEmpty) {
                            _performSearch(searchInputController.value.text);

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

            Expanded(
              child: FutureBuilder(
                  future: _futureSearchResult,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Check your internet connection!'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const Text(
                              "Recently Searched",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
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
                                    _performSearch(title);

                                    setState(() {
                                      searchInputController.text = title;
                                    });
                                  },
                                  onTapDelete: (title) {
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
                                        color: const Color(0xFF453944)
                                            .withOpacity(.05),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4))),
                                    child: const Text(
                                      "Clear All",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Article article = snapshot.data![index];
                          return ArticleItem(
                            isBookMarked: false,
                            imageUrl: article.urlToImage,
                            title: article.title,
                            source: article.source,
                            publishedAt: article.publishedAt,
                            author: article.author,
                            content: article.content,
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
