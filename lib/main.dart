import 'package:flutter/material.dart';
import 'package:news_api/selectable_chip.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = createMaterialColor(const Color(0xFF453944));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: const MyHomePage(pageTitle: 'Headlines'),
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
  late String selectedCategoryKey;

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
    selectedCategoryKey = categoriesMap.entries.first.key;
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
              // TODO: Open Filters Menu
            },
            icon: SvgPicture.asset('assets/icons/filter.svg')
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // TODO: Open Search Screen
                },
                icon:  SvgPicture.asset('assets/icons/search.svg'))
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoriesMap.entries.map((entry) {
                  return SelectableChip(
                    textLabel: entry.value,
                    isSelected: selectedCategoryKey == entry.key,
                    onTap: () {
                      /** 
                       If this chip isn't the selected one...
                       update Headlines data just before updating the selected state
                       This way, the update operation will only happen once and nothing
                       will happen if this chip is clicked multiple times. 
                      **/
                      if (entry.key != selectedCategoryKey) {
                        // TODO: Update Headlines data to match this category
                      }

                      setState(() {
                        selectedCategoryKey = entry.key;
                      });
                    },
                  );
                }).toList(),
              ))
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
