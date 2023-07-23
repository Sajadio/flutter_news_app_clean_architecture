// ignore_for_file: avoid_print, unused_element

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
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
      ..getAllHistoryHistoryNewsLetter();

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
                      localArticleCubit.addNewsletterToSearchHistory([
                        const Article(
                          id: 1,
                          author: "Devin Coldewey",
                          title:
                              "ChatGPT comes to Android next week, but you can sign up today | TechCrunch",
                          image:
                              "https://techcrunch.com/wp-content/uploads/2023/07/chatgpt-android.jpg?resize=1200,564",
                          time: "2023-07-21T21:18:32Z",
                        ),
                        const Article(
                          id: 2,
                          author: "Christine Hall",
                          title:
                              "Bolt, ex-CEO Ryan Breslow subject of SEC probe | TechCrunch",
                          image:
                              "https://techcrunch.com/wp-content/uploads/2022/01/Headshot_Ryan-Breslow-e1651272133788.jpg?w=1200",
                          time: "2023-07-21T21:15:26Z",
                        ),
                        const Article(
                          id: 3,
                          author: "Rita Liao",
                          title:
                              "Foreign visitors to China can finally go cashless like locals | TechCrunch",
                          image:
                              "https://techcrunch.com/wp-content/uploads/2019/12/alipay-alibaba-e1576983433919.jpg?resize=1200,639",
                          time: "2023-07-21T21:15:00Z",
                        ),
                        const Article(
                          id: 4,
                          author: "Christine Hall",
                          title:
                              "Bolt, ex-CEO Ryan Breslow subject of SEC probe | TechCrunch",
                          image:
                              "https://techcrunch.com/wp-content/uploads/2022/01/Headshot_Ryan-Breslow-e1651272133788.jpg?w=1200",
                          time: "2023-07-21T21:15:26Z",
                        ),
                        const Article(
                          id: 5,
                          author: "Christine Hall",
                          title:
                              "Bolt, ex-CEO Ryan Breslow subject of SEC probe | TechCrunch",
                          image:
                              "https://techcrunch.com/wp-content/uploads/2022/01/Headshot_Ryan-Breslow-e1651272133788.jpg?w=1200",
                          time: "2023-07-21T21:15:26Z",
                        ),
                      ]);
                    },
                    child: Text(
                      "History newsletter",
                      style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: normalFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDeleteConfirmationDialog(context, () {
                        localArticleCubit.deleteHistoryNewsLetter();
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
          title: const Text('Delete history newsletters'),
          content: const Text(
              'Are you sure you want to delete history newsletters?'),
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
