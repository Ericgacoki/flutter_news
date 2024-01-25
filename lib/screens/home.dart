import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/data/countries.dart';
import 'package:news_api/screens/search.dart';

import '../api_key.dart';
import '../model/article.dart';
import '../util/constants.dart';
import '../widgets/article_item.dart';
import '../widgets/checkable_source_chip.dart';
import '../widgets/selectable_chip.dart';
import '../widgets/top_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Map<String, String> categoriesMap;
  String selectedNewsCategoryId = "general";
  List<String> selectedSourcesIds = [];
  String selectedCountryId = "us";

  Future<List<Article>?>? _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = getArticles();
  }

  String url = "$BASE_URL/top-headlines?country=us&apiKey=$api_key";

  void formatArticleUrl({
    required String? category,
    required String? country,
    required String? source,
  }) {
    setState(() {
      if (source != null) {
        String sources = selectedSourcesIds.isNotEmpty
            ? "${selectedSourcesIds.join(',')},$source"
            : source;

        url = "$BASE_URL/everything?sources=$sources&apiKey=$api_key";
      } else if (country != null) {
        setState(() {
          selectedNewsCategoryId = "general";
        });
        url = "$BASE_URL/top-headlines?country=$country&apiKey=$api_key";
      } else if (category != null) {
        if (category != "general") {
          url =
              "$BASE_URL/top-headlines?category=$category&language=en&apiKey=$api_key";
        } else {
          url = "$BASE_URL/top-headlines?country=us&apiKey=$api_key";
        }
      } else {
        url = "$BASE_URL/top-headlines?country=us&apiKey=$api_key";
      }

      _futureArticles = getArticles();
    });
  }

  final Map<String, String> allSources = {
    "bbc-news": "BBC News",
    "cnn": "CNN",
    "espn": "ESPN",
    "reuters": "Reuters",
    "axios": "Axios",
    "cnbc": "CNBC",
    "abc-news": "ABC News",
  };

  final ScrollController listViewController = ScrollController();
  final ScrollController chipScrollController = ScrollController();

  _HomeScreenState()
      : categoriesMap = {
          "general": "General",
          "science": "Science",
          "technology": "Technology",
          "sports": "Sports",
          "entertainment": "Entertainment",
          "business": "Business",
          "health": "Health",
        } {
    selectedNewsCategoryId = categoriesMap.entries.first.key;
    selectedSourcesIds = [];
  }

  Future<List<Article>> getArticles() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == 'ok' && data['articles'] != null) {
        List<Article> articles = List.from(data['articles'])
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Invalid data format or missing articles key');
      }
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.pageTitle)],
          ),
          leading: IconButton(
              onPressed: () {
                showTopSheet(
                  context,
                  Container(
                    margin: const EdgeInsets.only(
                        top: 54, left: 16, right: 16, bottom: 24),
                    alignment: Alignment.topLeft,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back)),
                            const SizedBox(width: 30),
                            const Text(
                              "Filter what you see",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Lato'),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Source",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Lato'),
                        ),
                        const Text(
                          "News categories will not be available if you select specific source(s)",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lato'),
                        ),
                        const SizedBox(height: 12),

                        // TODO: Bug Alert!! The isChecked state is not being updated as expected!
                        Wrap(
                          runSpacing: 8,
                          children: allSources.entries.map((entry) {
                            return CheckableSourceChip(
                                onTap: (id) => {
                                      Navigator.pop(context),
                                      // Workaround the Bug mentioned above!

                                      formatArticleUrl(
                                          category: null,
                                          country: null,
                                          source: id),

                                      setState(() {
                                        selectedNewsCategoryId = "general";

                                        selectedSourcesIds.contains(id)
                                            ? selectedSourcesIds.remove(id)
                                            : selectedSourcesIds.add(id);
                                      })
                                    },
                                id: entry.key,
                                title: entry.value,
                                isChecked:
                                    selectedSourcesIds.contains(entry.key));
                          }).toList(),
                        ),

                        const SizedBox(height: 16),
                        const Text(
                          "Country",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Lato'),
                        ),
                        const Text(
                          "Sources will be ignored if you select a specific country",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lato'),
                        ),

                        // Drop down and Clear button
                        const SizedBox(
                          height: 16,
                        ),
                        DropdownMenu(
                          requestFocusOnTap: false,
                          label: const Text("Select country"),
                          initialSelection: selectedCountryId,
                          onSelected: (value) {
                            selectedCountryId = value ?? "us";
                            formatArticleUrl(
                                category: null,
                                country: selectedCountryId,
                                source: null);
                          },
                          dropdownMenuEntries: [
                            ...countriesData.entries.map((entry) =>
                                DropdownMenuEntry(
                                    value: entry.key, label: entry.value))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset('assets/icons/filter.svg')),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SearchScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutQuart;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: SvgPicture.asset('assets/icons/search.svg'))
          ]),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            controller: chipScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categoriesMap.entries.map(
                (entry) {
                  return SelectableChip(
                    textLabel: entry.value,
                    isSelected: selectedNewsCategoryId == entry.key,
                    onTap: () {
                      if (entry.key != selectedNewsCategoryId) {
                        formatArticleUrl(
                            category: entry.key, country: null, source: null);
                      }
                      setState(() {
                        selectedNewsCategoryId = entry.key;
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _futureArticles,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Check your internet connection!'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No articles available!'));
                  } else {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        // Determine the number of columns based on screen width
                        int columns = (constraints.maxWidth > 648) ? 2 : 1;

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 12,
                            childAspectRatio: MediaQuery.of(context)
                                    .size
                                    .width /
                                (columns *
                                    270), // 270 is the approx height of Article Item
                          ),
                          shrinkWrap: true,
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
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
