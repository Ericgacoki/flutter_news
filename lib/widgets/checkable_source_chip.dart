import 'package:flutter/material.dart';

class CheckableSourceChip extends StatelessWidget {
  const CheckableSourceChip(
      {super.key,
      required this.isChecked,
      required this.id,
      required this.title,
      required this.onTap});

  final bool isChecked;
  final String id, title;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(id),
      child: Container(
        margin: const EdgeInsets.only(right: 12), // Space outside
        padding: const EdgeInsets.all(8), // Space inside
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: isChecked
              ? const Color(0xFF453944)
              : const Color(0xFF453944).withOpacity(.24),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            isChecked
                ? Wrap(
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: Colors.white.withOpacity(.75)),
                      const SizedBox(width: 8)
                    ],
                  )
                : const SizedBox(),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: isChecked ? Colors.white : const Color(0xFF453944)),
            )
          ],
        ),
      ),
    );
  }
}
