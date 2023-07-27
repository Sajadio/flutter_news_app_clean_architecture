// ignore_for_file: avoid_print, unused_element

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/presentation/widget/article_card_widget.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';

@RoutePage()
class SearchScreen extends HookWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final localArticleCubit = BlocProvider.of<ArticleCubit>(context)
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
              BlocBuilder<ArticleCubit, ArticleState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case DataStateSuccess:
                      return _buildArticles(state.articles);
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

  Widget _buildArticles(List<Article?> articles) {
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
              showButton: false,
              article: articles[index]!,
              onClickCard: (id) {
                print(id);
              },
            );
          },
        ),
      );
    }
  }
}
