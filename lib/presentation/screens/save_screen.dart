// ignore_for_file: avoid_print, unused_element

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/presentation/widget/article_card_widget.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:flutter_news_app_clean_architecture/utils/config/app_router.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';

@RoutePage()
class SaveScreen extends HookWidget {
  const SaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ArticleCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved articles"),
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(
                context,
                () => {cubit.deleteAllArticles()},
              );
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: mediumSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: mediumSize),
            BlocBuilder<ArticleCubit, ArticleState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DataStateSuccess:
                    return _buildArticles(state.articles, (id) {
                      cubit.deleteArticle(state.articles.first);
                    }, (id) {
                      context.router.push(DetailsRoute(id: id));
                    });
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
    );
  }

  Widget _buildArticles(
    List<Article?> articles,
    Function(Article) onDeleteItem,
    Function(int) onClickItem,
  ) {
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
               showButton: true,
              article: articles[index]!,
              onClickCard: (id) => onClickItem.call(id),
            );
          },
        ),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    Function() onDelete,
  ) async {
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
