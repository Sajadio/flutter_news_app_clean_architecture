import 'package:flutter/material.dart';
import '../../utils/colors_app.dart';
import '../../utils/constant.dart';

class ChipWidget extends StatefulWidget {
  const ChipWidget({
    Key? key,
    required this.chipData,
    required this.onSelected,
  }) : super(key: key);

  final List<String> chipData;
  final void Function(String) onSelected;

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildChips(),
      ),
    );
  }

  List<Widget> _buildChips() {
    return widget.chipData.asMap().entries.map((entry) {
      final int index = entry.key;
      final String label = entry.value;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: normalSize),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediumSize),
            color: selectedIndex == index ? kPrimaryColor : kSecondaryColor,
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
                widget.onSelected.call(entry.value);
              });
            },
            child: Text(
              label,
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
                fontSize: normalFontSize,
                fontWeight: selectedIndex == index
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
