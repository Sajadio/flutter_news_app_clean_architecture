import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/utils/resource.dart';

abstract class Repository {
  void refreshCacheData(String? category);
  Future<Resource<List<Article>>> getCacheDataByCategory(String category);

  void addArticle(Article article);
  Future<Resource<Article>> getArticleById(int id);
  Future<Resource<List<Article>>> getAllSavedArticles();
  void deleteAllArticles();
  void deleteArticle(Article article);
  Future<bool?> didArticleSave(int id);
}
