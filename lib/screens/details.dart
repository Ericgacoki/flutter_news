import 'package:flutter/material.dart';

import '../util/date.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key,
      required this.isBookMarked,
      required this.imageUrl,
      required this.title,
      required this.source,
      required this.publishedAt,
      required this.author,
      required this.content});

  final String imageUrl, title, source, publishedAt, author, content;
  final bool isBookMarked;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 264,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                image: DecorationImage(
                    image: AssetImage(widget.imageUrl), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Article Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Authors, Source, PublishedAt, Bookmark Icon, Share Icon
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
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profile.png"),
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
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profile.png"),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 24,
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 2, color: Colors.white)),
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
                                widget.author,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.source,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    height: 4,
                                    width: 4,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    formatRelativeDate(widget.publishedAt),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
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
                              icon: Icon(widget.isBookMarked
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
                  ),

                  const SizedBox(height: 12),
                  // Content
                  Text(
                    widget.content,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
