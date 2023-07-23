// ignore_for_file: avoid_print, unused_element

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/source.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/local_article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/presentation/widget/article_card_widget.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';

@RoutePage()
class SearchScreen extends HookWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final localArticleCubit = BlocProvider.of<LocalArticleCubit>(context)
      ..getAllSavedArticles();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: mediumSize,
          right: mediumSize,
          top: mediumSize,
        ),
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kSecondaryColor),
                    child: IconButton(
                      onPressed: () {
                        context.popRoute();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: normalSize),
                  _buildSearchBar(textEditingController),
                ],
              ),
              const SizedBox(height: normalSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      localArticleCubit.addArticlesToSearchHistory([
                        const Article(
                          id: 1,
                          author: "Harry Stedman",
                          title:
                              "Elon Musk shares plans to replace Twitter bird logo with an X",
                          urlToImage:
                              "https://static.standard.co.uk/2023/07/01/19/4056694d8ea887ca533ac5e336ce4e2eY29udGVudHNlYXJjaGFwaSwxNjg4MzIwMjYz-2.18069972.jpg?width=1200&width=1200&auto=webp&quality=75",
                          publishedAt: "2023-07-21T21:18:32Z",
                          source: Source(id: null, name: "Evening Standard"),
                          content:
                              "Twitter owner Elon Musk appears to have suggested he will replace the social media platforms bird logo with an X.\r\nThe Tesla and SpaceX founder, who bought the company in October, tweeted on Sunday m… [+1395 chars]",
                          description:
                              "Elon Musk shares plans to replace Twitter bird logo with an Xstandard.co.uk",
                          url:
                              "https://www.standard.co.uk/news/world/elon-musk-twitter-spacex-mark-zuckerberg-larry-b1096183.html",
                        ),
                      ]);
                    },
                    child: Text(
                      "History Articles",
                      style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: normalFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDeleteConfirmationDialog(context, () {
                        localArticleCubit.deleteHistoryArticles();
                      });
                    },
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: normalFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              BlocBuilder<LocalArticleCubit, LocalArticleState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LocalArticleSuccess:
                      return _buildHistoryNewsLetter(state.articles);
                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(TextEditingController textEditingController) {
    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          style: TextStyle(color: kPrimaryTextColor),
          decoration: InputDecoration(
            fillColor: kSecondaryColor,
            hintText: "Search...",
            hintStyle: TextStyle(color: kSecondaryTextColor),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: kPrimaryColor,
          ),
          controller: textEditingController,
        ),
      ),
    );
  }

  Widget _buildHistoryNewsLetter(List<Article> articles) {
    if (articles.isEmpty) {
      return Center(
        child: SizedBox(
          child: Text(
            "No articles found",
            style: TextStyle(color: kSecondaryTextColor),
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return ArticleCardWidget(
              article: articles[index],
              onClickCard: (id) {
                print(id);
              },
            );
          },
        ),
      );
    }
  }

  Future<void> showDeleteConfirmationDialog(
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
