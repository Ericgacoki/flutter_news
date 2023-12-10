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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = createMaterialColor(const Color(0xFF453944));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
                        top: 50, left: 12, right: 12, bottom: 24),
                    alignment: Alignment.topLeft,
                    width: double.maxFinite,
                    child: Column(
                      children: List.generate(
                          10, (index) => (Text("Hello ${index + 1}"))),

                      // REMEMBER: Proceed from here! [Sun Dec 10, 2023]
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
            imageUrl: "assets/images/test_news_image.png",
            title: 'Shocking as Kenya is set to be sold to China!',
            source: "MLB Trade Rumors",
            publishedAt: "Today",
            authors: ["Quinn Parker", "Ethan James"],
          ),
          const AdItem(imageUrl: "assets/images/wallpaper.jpg"),
          const NewsItem(
            isBookMarked: false,
            imageUrl: "assets/images/wallpaper.jpg",
            title: 'Republican Sen Tim Scott suspends presidential campaign',
            source: "CNN",
            publishedAt: "2 days ago",
            authors: ["Leia Kiara", "Ethan James", "Quinn Parker"],
          ),
          const AdItem(imageUrl: "assets/images/wallpaper.jpg")
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
