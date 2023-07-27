import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import '../../utils/colors_app.dart';
import '../../utils/constant.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArticleCubit>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: mediumSize),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildChips(cubit),
      ),
    );
  }

  List<Widget> _buildChips(ArticleCubit cubit) {
    return cubit.chipsItems.asMap().entries.map((entry) {
      final int index = entry.key;
      final String label = entry.value;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: smallSize),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(normalSize),
            color:
                cubit.selectedIndex == index ? kPrimaryColor : kSecondaryColor,
          ),
          child: TextButton(
            onPressed: () {
              cubit.selectedIndex = index;
              onSelected.call(entry.value);
            },
            child: Text(
              label,
              style: TextStyle(
                letterSpacing: 0.4,
                color:
                    cubit.selectedIndex == index ? Colors.white : Colors.black,
                fontSize: normalFontSize,
                fontWeight: cubit.selectedIndex == index
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
