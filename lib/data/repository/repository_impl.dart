import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/mapper/entites/map_article_to_newsletter_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/mapper/map_newsletter_entity_to_article.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import '../dataSource/local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._localDataSource);

  @override
  Future<void> addArticlesToSearchHistory(List<Article> articles) async {
    List<ArticleEntity> articlesEntities = mapArticleToArticleEntity(articles);
    await _localDataSource.addArticlesToSearchHistory(articlesEntities);
  }

  @override
  Stream<List<Article>> getAllSavedArticles() {
    return _localDataSource.getAllSavedArticles().map(
        (articlesEntities) => mapArticleEntityToArticles(articlesEntities));
  }

  @override
  Future<void> deleteHistoryArticles() {
    return _localDataSource.deleteHistoryArticles();
  }

  @override
  Future<void> addArticle(Article article) async {
    List<ArticleEntity> articlesEntities = mapArticleToArticleEntity([article]);
    await _localDataSource.addArticle(articlesEntities.first);
  }

  @override
  Future<void> deleteArticle(Article article) async {
    List<ArticleEntity> articlesEntities = mapArticleToArticleEntity([article]);
    await _localDataSource.deleteArticle(articlesEntities.first);
  }

  @override
  Future<bool?> didArticleSave(String url) {
    return _localDataSource.didArticleSave(url);
  }
}
