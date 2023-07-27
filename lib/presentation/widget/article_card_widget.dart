import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/utils/format.dart';

import '../../utils/colors_app.dart';
import '../../utils/constant.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    Key? key,
    required this.article,
    required this.onClickCard,
    required this.showButton,
  }) : super(key: key);

  final Article article;
  final Function(int) onClickCard;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickCard(article.id!),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildImage(article.urlToImage),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildText(largeFontSize, 1, FontWeight.w500,
                        kPrimaryTextColor, article.author),
                    _buildText(mediumFontSize, 2, FontWeight.normal,
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
                              normalFontSize,
                              1,
                              FontWeight.normal,
                              kSecondaryTextColor,
                              getFormattedRelativeTime(
                                  article.publishedAt ?? "")),
                        ),
                        Expanded(
                          child: _buildText(
                              normalFontSize,
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
              showButton
                  ? IconButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, () => null);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: kPrimaryColor,
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: 140,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                width: 140,
                height: 120,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : const Placeholder(
              fallbackHeight: 120,
              fallbackWidth: 140,
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
