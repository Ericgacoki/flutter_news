import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  const NewsItem(
      {super.key,
      required this.isBookMarked,
      required this.imageUrl,
      required this.title,
      required this.source,
      required this.publishedAt,
      required this.authors});

  /// TODO: Use these fields after fetching the actual data
  final String imageUrl, title, source, publishedAt;
  final List<String> authors;
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
          Container(
            height: 220,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      const Color(0xFF453944).withOpacity(.5),
                      const Color(0xFF453944),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
                        // TODO: Add outline to the stacked containers
                        Positioned(
                          left: 0,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/profile.png"),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Center(child: Text("+2")),
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
                        authors[0],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Text(
                            source,
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
                            publishedAt,
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
                        //TODO: Open share bottom sheet
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
