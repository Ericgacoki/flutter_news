import 'package:flutter/material.dart';

class AdItem extends StatelessWidget {
  const AdItem({super.key});

  // TODO: Add required fields

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 300,
        margin: const EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
              image: AssetImage("assets/images/wallpaper.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFF453944).withOpacity(.8),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: const Text("Ad",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  const Color(0xFF453944).withOpacity(.5),
                  const Color(0xFF453944),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Get 30% Mockup discount",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
    );
  }
}
