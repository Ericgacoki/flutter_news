import 'package:flutter/material.dart';

// TODO: Try Video Ads 💀
class AdItem extends StatelessWidget {
  const AdItem({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: double.maxFinite,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
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
                  color: const Color(0xFF453944).withOpacity(.8),
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
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Icon(
                  Icons.cancel_rounded,
                  color: const Color(0xFF453944).withOpacity(.8)),
            ),
          ),
        ],
      ),
    );
  }
}
