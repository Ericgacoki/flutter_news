import 'package:news_api/model/source.dart';

class Article {
  final String title, description, content, author, urlToImage, publishedAt;
  final Source source;

  const Article({
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.source,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        content: json["content"] ?? '',
        author: json["author"] ?? '',
        source: Source.fromJson(json['source']),
        urlToImage: json["urlToImage"] ?? '',
        publishedAt: json["publishedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "content": content,
        "author": author,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt
      };
}
