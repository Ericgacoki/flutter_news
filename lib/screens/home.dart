import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_api/screens/search.dart';

import '../util/dummy_article_content.dart';
import '../widgets/ad_item.dart';
import '../widgets/checkable_source_chip.dart';
import '../widgets/news_item.dart';
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
  late String selectedNewsCategoryId;
  late List<String> selectedSourcesIds;

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
                        // Try: Copy states an update them simultaneously. The state within this context/top-sheet
                        // will be used to only update the UI
                        Wrap(
                          runSpacing: 8,
                          children: allSources.entries.map((entry) {
                            return CheckableSourceChip(
                                onTap: (id) => {
                                      setState(() {
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
                        const DropdownMenu(
                          requestFocusOnTap: false,
                          label: Text("Select country"),
                          initialSelection: "NS", // TODO: "Hoist" this state.
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                                value: "NS", label: "Not Specified"),
                            DropdownMenuEntry(
                                value: "US", label: "🇺🇸   United States"),
                            DropdownMenuEntry(
                                value: "UK", label: "🇬🇧   United Kingdom"),
                            DropdownMenuEntry(
                                value: "GE", label: "🇩🇪   Germany"),
                            DropdownMenuEntry(
                                value: "NG", label: "🇳🇬   Nigeria"),
                            DropdownMenuEntry(
                                value: "TZ", label: "🇹🇿   Tanzania")
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
      body: ListView(
        controller: listViewController,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SingleChildScrollView(
            controller: chipScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              // TODO: Hide these categories if "source" has been specified...(as per API docs)
              children: categoriesMap.entries.map(
                (entry) {
                  return SelectableChip(
                    textLabel: entry.value,
                    isSelected: selectedNewsCategoryId == entry.key,
                    onTap: () {
                      /**
                          If this chip isn't the selected one...
                          update Headlines data just before updating the selected state
                          This way, the update operation will only happen once and nothing
                          will happen if this chip is clicked multiple times. Cool, right?
                       **/
                      if (entry.key != selectedNewsCategoryId) {
                        // TODO: Fetch Headlines data in this category
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
          const NewsItem(
            isBookMarked: true,
            imageUrl: "assets/images/customers.jpg",
            title:
                'Experts raise concerns about U.S. commitment to GPS modernization',
            source: "MLB Trade Rumors",
            publishedAt: "2023-12-10T00:00:00Z",
            author: "Quinn Parker",
            content: content_1,
          ),
          const AdItem(imageUrl: "assets/images/spotify_ad.png"),
          const NewsItem(
            isBookMarked: false,
            imageUrl: "assets/images/phone_ad.jpg",
            title: 'Crypto lawyer wants to depose Changpeng',
            source: "CNN",
            publishedAt: "2023-12-09T00:00:00Z",
            author: "Leia Kiara",
            content: content_1,
          ),
          const AdItem(imageUrl: "assets/images/phone_ad.jpg")
        ],
      ),
    );
  }
}
