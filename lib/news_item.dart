import 'package:flutter/material.dart';

class RoundCorneredChip extends StatelessWidget {
  const RoundCorneredChip({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor:  const Color(0xFF453944),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
