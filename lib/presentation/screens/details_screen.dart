import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/local_article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final articleCubit = BlocProvider.of<LocalArticleCubit>(context);

    return BlocBuilder<LocalArticleCubit, LocalArticleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              article.author ?? "",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: articleCubit.didArticleSave(article.url!)
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_add_outlined),
                onPressed: () {
                  articleCubit.addArticle(article);
                },
              ),
              IconButton(
                onPressed: () {
                  shareUrl(article);
                },
                icon: const Icon(Icons.share),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: normalSize),
                _buildText(
                  largeFontSize,
                  FontWeight.bold,
                  kPrimaryTextColor,
                  article.title,
                ),
                _buildText(
                  normalFontSize,
                  FontWeight.normal,
                  kSecondaryTextColor,
                  article.publishedAt,
                ),
                const SizedBox(height: normalSize),
                // _buildImage(
                //   context,
                //   article.urlToImage,
                // ),
                const SizedBox(
                  height: normalSize,
                ),
                _buildText(
                  normalFontSize,
                  FontWeight.normal,
                  kSecondaryTextColor,
                  article.description,
                ),
                _buildText(
                  normalFontSize,
                  FontWeight.normal,
                  kSecondaryTextColor,
                  article.content,
                ),
                Link(
                    uri: Uri.parse(article.url ?? ""),
                    target: LinkTarget.defaultTarget,
                    builder: (context, openLink) => TextButton(
                          onPressed: openLink,
                          child: _buildText(
                            normalFontSize,
                            FontWeight.normal,
                            Colors.blue,
                            "Read more",
                          ),
                        ))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> shareUrl(Article article) async {
    await FlutterShare.share(
        title: article.title!, text: article.description, linkUrl: article.url);
  }

  Widget _buildText(
    double fontSize,
    FontWeight fontWeight,
    Color color,
    String? title,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title ?? "",
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            height: 1.3),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String? imageUrl) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.5;

    return Image.network(
      imageUrl ?? "",
      fit: BoxFit.cover,
      height: imageHeight,
    );
  }
}
