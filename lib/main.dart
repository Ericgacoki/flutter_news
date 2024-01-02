import 'package:flutter/material.dart';
import 'package:news_api/screens/home.dart';
import 'package:news_api/util/material_color.dart';

void main() => runApp(const NewsApiApp());

class NewsApiApp extends StatelessWidget {
  const NewsApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = createMaterialColor(const Color(0xFF453944));
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Lato',
        primarySwatch: customColor,
      ),
      home: const HomeScreen(pageTitle: 'Top Headlines'),
    );
  }
}
