import 'package:flutter/material.dart';
import 'package:news_api/widgets/remove_ad_pager_content.dart';

// TODO: Try Video Ads 💀
class AdItem extends StatefulWidget {
  const AdItem({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<AdItem> createState() => _AdItemState();
}

class _AdItemState extends State<AdItem> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: double.maxFinite,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage(widget.imageUrl), fit: BoxFit.cover),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ad text
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFF453944).withOpacity(.75),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: const Text("Ad",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)),
            ),
          ),

          // Cancel button (requires premium)
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      alignment: AlignmentDirectional.topCenter,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          /** Used as drag handle */
                          Container(
                            margin: const EdgeInsets.all(12),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey.withOpacity(.75),
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              scrollDirection: Axis.horizontal,
                              controller: _pageController,
                              children: const <Widget>[
                                RemoveAdPagerContent(
                                    imagePath: "assets/images/spotify_ad.png",
                                    displayText: "This is a sample text"),
                                RemoveAdPagerContent(
                                    imagePath: "assets/images/phone_ad.jpg",
                                    displayText: "This is a sample text")
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFF453944).withOpacity(.5),
                    borderRadius: const BorderRadius.all(Radius.circular(24))),
                child: const Text(
                  "X",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
