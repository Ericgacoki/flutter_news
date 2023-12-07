import 'package:flutter/material.dart';

class SelectableChip extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableChip({super.key, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilterChip(
        label: Text(
          'Chip $isSelected',
          style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF453944)),
        ),
        selected: isSelected,
        onSelected: (bool selected) => onTap(),
        backgroundColor: isSelected ? const Color(0xFF453944) : Colors.transparent,
        selectedColor: const Color(0xFF453944),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFF453944),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

class SelectableChipsRow extends StatefulWidget {
  const SelectableChipsRow({super.key});

  @override
  SelectableChipsRowState createState() => SelectableChipsRowState();
}

class SelectableChipsRowState extends State<SelectableChipsRow> {
  int selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => SelectableChip(
          isSelected: selectedChipIndex == index,
          onTap: () {
            setState(() {
              selectedChipIndex = index;
            });
          },
        ),
      ),
    );
  }
}