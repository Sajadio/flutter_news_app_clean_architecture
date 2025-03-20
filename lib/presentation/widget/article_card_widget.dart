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
    return IntrinsicHeight(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(normalSize)),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      onClickCard(article.id!);
                    },
                    child: _buildImage(article.urlToImage))),
            const SizedBox(width: normalSize),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.author.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextTheme.of(context)
                        .bodyLarge!
                        .copyWith(color: kSecondaryTextColor),
                  ),
                  Text(
                    article.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextTheme.of(context)
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        getFormattedRelativeTime(article.publishedAt ?? ""),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextTheme.of(context)
                            .labelSmall!
                            .copyWith(color: kSecondaryTextColor),
                      )),
                      Expanded(
                          child: Text(
                        getFormattedDateTime(article.publishedAt ?? ""),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextTheme.of(context)
                            .labelSmall!
                            .copyWith(color: kSecondaryTextColor),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(normalSize),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: 200,
              height: 150,
              fit: BoxFit.fill,
              placeholder: (context, url) => SizedBox(
                width: 200,
                height: 200,
                child: Image.network(url),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : const Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 200,
            ),
    );
  }
}
