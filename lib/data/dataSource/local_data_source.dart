import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';

abstract class LocalDataSource {
  Future<void> addArticle(ArticleEntity articleEntity);
  Stream<List<ArticleEntity>> getAllSavedArticles();
  Future<void> deleteAllArticles();
  Future<void> deleteArticle(ArticleEntity articleEntity);
  Future<bool?> didArticleSave(String url);
}
