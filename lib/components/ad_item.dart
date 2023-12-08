import 'package:flutter/material.dart';

class AdItem extends StatelessWidget {
  const AdItem({super.key});

  // TODO: Add required fields

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 300,
        margin: const EdgeInsets.all(8),
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
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: const Text("Ad",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF453944).withOpacity(.6),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
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
