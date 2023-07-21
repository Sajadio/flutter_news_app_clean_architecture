import 'package:flutter/material.dart';

import '../../utils/colors_app.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    Key? key,
    required this.onClickCard,
  }) : super(key: key);

  final Function() onClickCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickCard,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildImage(""),
                Expanded(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildText(14, 1, FontWeight.w500, kPrimaryTextColor,
                          "New York Times"),
                      _buildText(14, 2, FontWeight.normal, kPrimaryTextColor,
                          "One measure of 'the market' is up 34% this year while another is only up 6%—here's why"),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildText(14, 1, FontWeight.normal,
                              kSecondaryTextColor, "3 weeks ago"),
                          _buildText(14, 1, FontWeight.normal,
                              kSecondaryTextColor, "Fir, 18 Feb 2023")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        "https://mma.prnewswire.com/media/2159579/The_Dawn_Project_Tesla.mp4?p=medium",
        fit: BoxFit.cover,
        width: 140,
        height: 120,
      ),
    );
  }

  Widget _buildText(
    double fontSize,
    int maxLine,
    FontWeight fontWeight,
    Color color,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 8),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLine,
        style:
            TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      ),
    );
  }
}
