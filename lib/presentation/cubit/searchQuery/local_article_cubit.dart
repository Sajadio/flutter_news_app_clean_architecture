// ignore_for_file: unused_field, avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/add_items_to_search_history_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/delete_history_newletter_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/get_all_history_newsletter_use_case.dart';

part 'local_article_state.dart';

class LocalArticleCubit extends Cubit<LocalArticleState> {
  LocalArticleCubit(
    this._addNewsletterToSearchHistoryUseCase,
    this._getAllNewsletterHistoryUseCase,
    this._deleteHistoryNewsLetterUseCase,
  ) : super(LocalArticleLoading());

  final AddHistoryNewsletterUserCase _addNewsletterToSearchHistoryUseCase;
  final GetAllHistoryNewsletterCase _getAllNewsletterHistoryUseCase;
  final DeleteHistoryNewsLetterUseCase _deleteHistoryNewsLetterUseCase;

  void addNewsletterToSearchHistory(List<Article> newsletter) async {
    emit(LocalArticleLoading());
    await _addNewsletterToSearchHistoryUseCase.call(newsletter);
  }

  void getAllHistoryHistoryNewsLetter() {
    emit(LocalArticleLoading());
    _getAllNewsletterHistoryUseCase.call().listen((articles) {
      emit(LocalArticleSuccess(articles: articles));
    }, onError: (error) {});
  }

  void deleteHistoryNewsLetter() async {
    _deleteHistoryNewsLetterUseCase.call();
  }
}
