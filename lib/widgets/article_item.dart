import 'package:flutter/material.dart';
import 'package:news_api/screens/details.dart';
import 'package:news_api/util/date.dart';
import 'package:news_api/util/format_author.dart';

import '../model/source.dart';
import '../util/render_image.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(
      {super.key,
      required this.isBookMarked,
      required this.imageUrl,
      required this.title,
      required this.source,
      required this.publishedAt,
      required this.author,
      required this.content});

  final String title, publishedAt, author, content;
  final String? imageUrl;
  final Source source;
  final bool isBookMarked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Article image, shade, title
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DetailsScreen(
                    isBookMarked: isBookMarked,
                    imageUrl: imageUrl,
                    title: title,
                    source: source,
                    publishedAt: publishedAt,
                    author: author,
                    content: content,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutQuart;

                    final tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );

                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              height: 220,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: renderImage(imageUrl), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            const Color(0xFF453944).withOpacity(.5),
                            const Color(0xFF453944),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Article Author(s), Source, date and action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Only 2 children to create an end-to-end placement
              Row(
                // Author Images and Texts
                children: [
                  SizedBox(
                    height: 32,
                    width: 56,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/profile.png"),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.white)),
                            child: Center(
                              child: Text(
                                countAuthors(author),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatAuthor(author),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Text(
                            source.name.length > 24
                                ? '${source.name.substring(0, 24)}...'
                                : source.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            formatRelativeDate(publishedAt),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),

              Row(
                // End Icons
                children: [
                  IconButton(
                      onPressed: () {
                        //TODO: Add/Remove news item to/from bookmarks
                      },
                      icon: Icon(isBookMarked
                          ? Icons.bookmark
                          : Icons.bookmark_add_outlined)),
                  const SizedBox(width: 12),
                  IconButton(
                      onPressed: () {
                        // shareArticle(Uri());
                      },
                      icon: const Icon(Icons.share_outlined)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
