import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import '../components/ad_item.dart';
import '../components/news_item.dart';
import '../components/selectable_chip.dart';

void main() {
  runApp(const NewsApiApp());
}

class NewsApiApp extends StatelessWidget {
  const NewsApiApp({super.key});

  // This widget is the root of your app.
  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = createMaterialColor(const Color(0xFF453944));

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: customColor,
      ),
      home: const MyHomePage(pageTitle: 'Top Headlines'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Map<String, String> categoriesMap;
  late String selectedNewsCategoryKey;

  final ScrollController listViewController = ScrollController();
  final ScrollController chipScrollController = ScrollController();

  _MyHomePageState()
      : categoriesMap = {
          "science": "Science",
          "technology": "Technology",
          "sports": "Sports",
          "entertainment": "Entertainment",
          "business": "Business",
          "health": "Health",
          "general": "General",
        } {
    selectedNewsCategoryKey = categoriesMap.entries.first.key;
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
              onPressed: () async {
                await showTopModalSheet<String?>(
                  context,
                  Container(
                    margin: const EdgeInsets.only(
                        top: 50, left: 16, right: 16, bottom: 24),
                    alignment: Alignment.topLeft,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_back)),
                            const SizedBox(width: 30),
                            const Text(
                              "Filter what you see",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lato'),
                        ),

                        const SizedBox(height: 150),
                        // TODO: Add flow layout with checkable chips here

                        const Text(
                          "Country",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Lato'),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Sources will be ignored if you select a specific country",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lato'),
                        ),

                        // Drop down and Clear button
                        const SizedBox(
                          height: 12,
                        ),
/*
                        GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.all(16.0),
                                  color: Colors.blue,
                                  // Replace with your desired container color
                                  child: Center(
                                    child: Text(
                                      'Container ${index + 1}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ));
                            }),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 40,
                              color: Colors.blue,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12, left: 8),
                              child: MaterialButton(
                                color: const Color(0XFFF5ECF4),
                                onPressed: () {},
                                child: const Text(
                                  "Clear Selection",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
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
                  // TODO: Open Search Screen
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
              children: categoriesMap.entries.map(
                (entry) {
                  return SelectableChip(
                    textLabel: entry.value,
                    isSelected: selectedNewsCategoryKey == entry.key,
                    onTap: () {
                      /**
                          If this chip isn't the selected one...
                          update Headlines data just before updating the selected state
                          This way, the update operation will only happen once and nothing
                          will happen if this chip is clicked multiple times.
                       **/
                      if (entry.key != selectedNewsCategoryKey) {
                        // TODO: Update Headlines data to match this category
                      }
                      setState(() {
                        selectedNewsCategoryKey = entry.key;
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
            publishedAt: "Today",
            author: "Quinn Parker",
          ),
          const AdItem(imageUrl: "assets/images/phone_ad.jpg"),
          const NewsItem(
            isBookMarked: false,
            imageUrl: "assets/images/wallpaper.jpg",
            title: 'Crypto lawyer wants to depose Changpeng',
            source: "CNN",
            publishedAt: "2 days ago",
            author: "Leia Kiara",
          ),
          const AdItem(imageUrl: "assets/images/spotify_ad.png"),
        ],
      ),
    );
  }
}

// Function to create a MaterialColor from a single color
MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int red = color.red, green = color.green, blue = color.blue;

  for (int strength in strengths) {
    swatch[strength] = Color.fromRGBO(red, green, blue, 1.0);
  }

  return MaterialColor(color.value, swatch);
}
