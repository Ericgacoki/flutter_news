import 'package:flutter/material.dart';

class RemoveAdPagerContent extends StatelessWidget {
  const RemoveAdPagerContent(
      {super.key, required this.imagePath, required this.displayText});

  final String imagePath, displayText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Center(
        child: Column(
          children: [
            Container(
              height: 240,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            Text(displayText, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => {},
              child: const Text("Try Premium"),
            )
          ],
        ),
      ),
    );
  }
}
