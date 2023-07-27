import 'package:floor/floor.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/cache_article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';

@dao
abstract class ArticleDao implements LocalDataSource {
  @override
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addCacheData(List<CacheArticleEntity> entities);

  @override
  @Query('SELECT * FROM CacheArticleEntity WHERE category = :category')
  Future<List<CacheArticleEntity>?> getCacheDataByCategory(String category);

  @override
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addArticle(ArticleEntity entities);

  @override
  @Query('SELECT * FROM ArticleEntity WHERE id = :id')
  Future<ArticleEntity?> getArticleById(int id);

  @override
  @Query('SELECT * FROM ArticleEntity')
  Future<List<ArticleEntity>?> getAllSavedArticles();

  @override
  @Query('DELETE FROM ArticleEntity')
  Future<void> deleteAllArticles();

  @override
  @delete
  Future<void> deleteArticle(ArticleEntity entities);

  @Query('SELECT EXISTS (SELECT 1 FROM ArticleEntity WHERE id = :id LIMIT 1)')
  @override
  Future<bool?> didArticleSave(int id);
}
