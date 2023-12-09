import 'package:flutter/material.dart';

class SelectableChip extends StatelessWidget {
  final String textLabel;
  final bool isSelected;
  final VoidCallback onTap;

  final Color chipColor = const Color(0xFF453944);

  const SelectableChip(
      {super.key,
      required this.textLabel,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilterChip( // TODO: Replace this with a custom Chip - Use container
        label: Text(
          textLabel,
          style: TextStyle(color: isSelected ? Colors.white : chipColor),
        ),
        selected: isSelected,
        onSelected: (bool selected) => onTap(),
        backgroundColor: isSelected ? chipColor : Colors.transparent,
        selectedColor: chipColor,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Colors.transparent : chipColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
