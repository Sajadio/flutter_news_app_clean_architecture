import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/cache_article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';

abstract class LocalDataSource {
  Future<void> addCacheData(List<CacheArticleEntity> entities);
  Future<List<CacheArticleEntity>?> getCacheDataByCategory(String category);

  Future<void> addArticle(ArticleEntity entity);
  Future<ArticleEntity?> getArticleById(int id);
  Future<List<ArticleEntity>?> getAllSavedArticles();
  Future<void> deleteAllArticles();
  Future<void> deleteArticle(ArticleEntity entity);
  Future<bool?> didArticleSave(int id);
}
