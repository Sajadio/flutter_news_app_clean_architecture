import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';

import '../../domain/model/article.dart';
import '../../utils/format.dart';

class CardSlider extends StatelessWidget {
  const CardSlider({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250.0,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: smallSize,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mediumSize)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              article.urlToImage.toString(),
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black
                    .withValues(alpha: 0.3), // 30% Transparent Black
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          article.author.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const Icon(
                          CupertinoIcons.circle_fill,
                          color: Colors.white,
                          size: 8,
                        ),
                        Text(
                            getFormattedRelativeTime(article.publishedAt ?? ""),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white))
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.content.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}