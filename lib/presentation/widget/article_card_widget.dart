import 'package:flutter/material.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import '../../utils/colors_app.dart';
import '../../utils/constant.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    Key? key,
    required this.article,
    required this.onClickCard,
  }) : super(key: key);

  final Article article;

  final Function(int) onClickCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickCard(article.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildImage(article.image),
              Expanded(
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildText(mediumFontSize, 1, FontWeight.w500,
                        kPrimaryTextColor, article.author),
                    _buildText(normalFontSize, 2, FontWeight.normal,
                        kPrimaryTextColor, article.title),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildText(smallFontSize, 1, FontWeight.normal,
                              kSecondaryTextColor, article.time),
                        ),
                        Expanded(
                          child: _buildText(smallFontSize, 1, FontWeight.normal,
                              kSecondaryTextColor, article.time),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
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
