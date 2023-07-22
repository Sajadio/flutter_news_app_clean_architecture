import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';

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
        children: buildChips(),
      ),
    );
  }

  List<Widget> buildChips() {
    return widget.chipData.asMap().entries.map((entry) {
      final int index = entry.key;
      final String label = entry.value;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ChoiceChip(
          backgroundColor: kSecondaryColor,
          selectedColor: kPrimaryColor,
          selected: selectedIndex == index,
          label: Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
          onSelected: (selected) {
            setState(() {
              selectedIndex = index;
              widget.onSelected.call(entry.value);
            });
          },
        ),
      );
    }).toList();
  }
}
