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

part 'local_article_state.dart';

class LocalArticleCubit extends Cubit<LocalArticleState> {
  LocalArticleCubit(
    this._addArticleUseCase,
    this._getAllSavedArticlesUseCase,
    this._deleteAllArticlesUseCase,
    this._deleteArticleUseCase,
    this._didArticleSaveUseCase,
  ) : super(LocalArticleLoading());

  final AddArticleCaseCase _addArticleUseCase;
  final GetAllSavedArticlesUseCase _getAllSavedArticlesUseCase;
  final DeleteAllArticlesUseCase _deleteAllArticlesUseCase;
  final DeleteArticleCaseCase _deleteArticleUseCase;
  final DidArticleSaveUseCase _didArticleSaveUseCase;

  void addArticle(Article article) async {
    emit(LocalArticleLoading());
    await _addArticleUseCase.call(article);
  }

  void getAllSavedArticles() {
    emit(LocalArticleLoading());
    _getAllSavedArticlesUseCase.call().listen((articles) {
      emit(LocalArticleSuccess(articles: articles));
    }, onError: (error) {});
  }

  void deleteAllArticles() async {
    _deleteAllArticlesUseCase.call();
  }

  void deleteArticle(Article article) async {
    _deleteArticleUseCase.call(article);
  }

  bool didArticleSave(String url) {
    bool? isSaved = false;
    final completer = Completer<bool>();

    _didArticleSaveUseCase.call(url).then((value) {
      isSaved = value;
      completer.complete(isSaved);
    }).catchError((error) {
      completer.completeError(error);
    });

    print(isSaved);

    return isSaved!;
  }
}
