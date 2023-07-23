import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/history_newsletter_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/mapper/entites/map_article_to_newsletter_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/mapper/map_newsletter_entity_to_article.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import '../dataSource/local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._localDataSource);

  @override
  Future<void> addNewsletterToSearchHistory(List<Article> articles) async {
    List<HistoryNewsletterEntity> historyEntities =
        mapArticlesToHistoryNewsLetter(articles);
    await _localDataSource.addItemsToSearchHistory(historyEntities);
  }

  @override
  Stream<List<Article>> getAllHistoryHistoryNewsletter() {
    return _localDataSource.getAllHistoryHistoryNewsletter().map(
        (historyEntities) => mapHistoryNewsLettersToArticles(historyEntities));
  }

  @override
  Future<void> deleteHistoryNewsLetter() {
    return _localDataSource.deleteHistoryNewsLetter();
  }
}
