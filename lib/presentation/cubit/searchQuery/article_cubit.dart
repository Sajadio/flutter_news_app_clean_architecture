// ignore_for_file: unused_field, avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/add_article_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_article_use_case%20copy.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_all_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/did_article_save_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_all_saved_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_article_by_id_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_cache_data_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/refresh_cache_data_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/utils/resource.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit(
    this._addArticleUseCase,
    this._getAllSavedArticlesUseCase,
    this._deleteAllArticlesUseCase,
    this._deleteArticleUseCase,
    this._didArticleSaveUseCase,
    this._getArticleByIdUseCase,
    this._refreshCacheUseCase,
    this._getCacheUseCase,
  ) : super(DataStateInitial());

  final AddArticleCaseCase _addArticleUseCase;
  final GetAllSavedArticlesUseCase _getAllSavedArticlesUseCase;
  final DeleteAllArticlesUseCase _deleteAllArticlesUseCase;
  final DeleteArticleCaseCase _deleteArticleUseCase;
  final DidArticleSaveUseCase _didArticleSaveUseCase;
  final GetArticleByIdUseCase _getArticleByIdUseCase;
  final RefreshCacheCaseCase _refreshCacheUseCase;
  final GetCacheCaseCase _getCacheUseCase;

  int selectedIndex = 0;

  final chipsItems = const [
    "general",
    "business",
    "entertainment",
    "technology",
    "sports",
    "health",
    "science",
  ];

  void refreshCacheData(String? category) {
    _refreshCacheUseCase.call(chipsItems[selectedIndex]);
    _getCacheData(category);
  }

  void _getCacheData(category) async {
    emit(const DataStateSuccess(articles: [
      Article(
        id: 1,
        author: "Elon Musk",
        title:
            "Tesla's challenges run deeper than 'toxic' controversy around Elon",
        urlToImage:
            "https://ichef.bbci.co.uk/news/1024/branded_news/15ab/live/a5c8b260-04c4-11f0-97d3-37df2b293ed1.png",
        publishedAt: "2025-03-20T00:41:00Z",
        content:
            "f you click 'Accept all', we and our partners, including 239 who are part of the IAB Transparency &amp; Consent Framework, will also store and/or access information on a device (in other words, use … [+702 chars]",
      ),
      Article(
        id: 1,
        author: "ABC News",
        title:
            "WATCH: Lightning strike captured by dashboard camera in Atlanta",
        urlToImage:
            "https://i.abcnewsfe.com/a/0afe294a-dbd7-49fc-a8da-0548169e06b6/250319_abc_social_atl_lightning_hpMain_16x9.jpg?w=992",
        publishedAt: "2025-03-20T00:41:00Z",
        content:
            "f you click 'Accept all', we and our partners, including 239 who are part of the IAB Transparency &amp; Consent Framework, will also store and/or access information on a device (in other words, use … [+702 chars]",
      ),
      Article(
        id: 1,
        author: "Charlie Nash",
        title:
            "Tesla's challenges run deeper than 'toxic' controversy around Elon",
        urlToImage:
            "https://www.mediaite.com/wp-content/uploads/2025/03/Tarlov.jpg",
        publishedAt: "2025-03-20T00:41:00Z",
        content:
            "f you click 'Accept all', we and our partners, including 239 who are part of the IAB Transparency &amp; Consent Framework, will also store and/or access information on a device (in other words, use … [+702 chars]",
      ),
    ]));
    // emit(DataStateLoading());
    // final resource = await _getCacheUseCase.call(category);
    // switch (resource.status) {
    //   case ResourceStatus.success:
    //     emit(DataStateSuccess(articles: resource.data!));
    //     break;
    //   case ResourceStatus.failure:
    //     emit(DataStateFailure(
    //         errors: resource.exception?.toString() ?? 'Unknown error'));
    //     break;
    // }
  }

  void addArticle(Article article) async {
    emit(DataStateLoading());
    _addArticleUseCase.call(article);
  }

  void getArticleById(int id) async {
    final resource = await _getArticleByIdUseCase.call(id);
    emit(DataStateLoading());
    switch (resource.status) {
      case ResourceStatus.success:
        emit(DataStateSuccess(articles: [resource.data!]));
        break;
      case ResourceStatus.failure:
        emit(DataStateFailure(
            errors: resource.exception?.toString() ?? 'Unknown error'));
        break;
    }
  }

  void getAllSavedArticles() async {
    emit(DataStateLoading());
    final resource = await _getAllSavedArticlesUseCase.call();
    switch (resource.status) {
      case ResourceStatus.success:
        emit(DataStateSuccess(articles: resource.data!));
        break;
      case ResourceStatus.failure:
        emit(DataStateFailure(
            errors: resource.exception?.toString() ?? 'Unknown error'));
        break;
    }
  }

  void deleteAllArticles() async {
    _deleteAllArticlesUseCase.call();
  }

  void deleteArticle(Article article) async {
    _deleteArticleUseCase.call(article);
  }

  bool didArticleSave(int id) {
    bool? isSaved = false;
    final completer = Completer<bool>();

    _didArticleSaveUseCase.call(id).then((saved) {
      isSaved = saved;
      completer.complete(saved);
    }).catchError((error) {
      completer.completeError(error);
    });
    print(isSaved);
    return isSaved!;
  }
}
