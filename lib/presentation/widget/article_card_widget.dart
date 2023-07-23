import 'package:flutter/material.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/utils/format.dart';
import 'package:intl/intl.dart';

import '../../utils/colors_app.dart';
import '../../utils/constant.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    Key? key,
    required this.article,
    required this.onClickCard,
  }) : super(key: key);

  final Article article;

  final Function(int?) onClickCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickCard(article.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildImage(
                  "https://static.standard.co.uk/2023/07/01/19/4056694d8ea887ca533ac5e336ce4e2eY29udGVudHNlYXJjaGFwaSwxNjg4MzIwMjYz-2.18069972.jpg?width=1200&width=1200&auto=webp&quality=75"),
              Expanded(
                child: Column(
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
                          child: _buildText(
                              smallFontSize,
                              1,
                              FontWeight.normal,
                              kSecondaryTextColor,
                              getFormattedRelativeTime(
                                  article.publishedAt ?? "")),
                        ),
                        Expanded(
                          child: _buildText(
                              smallFontSize,
                              1,
                              FontWeight.normal,
                              kSecondaryTextColor,
                              getFormattedDateTime(article.publishedAt ?? "")),
                        )
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, () => null);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: kPrimaryColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl ?? "",
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
    String? title,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 8),
      child: Text(
        title ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: maxLine,
        style:
            TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      ),
    );
  }



  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, Function() onDelete) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete history articles'),
          content:
              const Text('Are you sure you want to delete history articles?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
