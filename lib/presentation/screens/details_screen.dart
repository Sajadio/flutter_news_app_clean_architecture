import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';
import 'package:flutter_news_app_clean_architecture/utils/format.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final articleCubit = BlocProvider.of<ArticleCubit>(context);
    articleCubit.getArticleById(id);

    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.articles.first.author ?? "",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: articleCubit.didArticleSave(state.articles.first.id!)
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_add_outlined),
                onPressed: () {
                  articleCubit.addArticle(state.articles.first);
                },
              ),
              IconButton(
                onPressed: () {
                  shareUrl(state.articles.first);
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
                  state.articles.first.title,
                ),
                _buildText(
                  mediumFontSize,
                  FontWeight.normal,
                  kSecondaryTextColor,
                  "${getFormattedRelativeTime(state.articles.first.publishedAt ?? "")}\t ${getFormattedDateTime(state.articles.first.publishedAt ?? "")}",
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
                  mediumFontSize,
                  FontWeight.normal,
                  kSecondaryTextColor,
                  state.articles.first.description,
                ),
                _buildText(
                  mediumFontSize,
                  FontWeight.normal,
                  kSecondaryTextColor,
                  state.articles.first.content,
                ),
                Link(
                    uri: Uri.parse(state.articles.first.url ?? ""),
                    target: LinkTarget.defaultTarget,
                    builder: (context, openLink) => TextButton(
                          onPressed: openLink,
                          child: _buildText(
                            mediumFontSize,
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
