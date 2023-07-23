import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

abstract class Repository {
  Future<void> addArticle(Article article);
  Stream<List<Article>> getAllSavedArticles();
  Future<void> deleteAllArticles();
  Future<void> deleteArticle(Article article);
  Future<bool?> didArticleSave(String url);
}
