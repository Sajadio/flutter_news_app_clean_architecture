import 'package:floor/floor.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';

@dao
abstract class ArticleDao implements LocalDataSource {

  @override
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addArticle(ArticleEntity articleEntity);

  @override
  @Query('SELECT * FROM ArticleEntity')
  Stream<List<ArticleEntity>> getAllSavedArticles();

  @override
  @Query('DELETE FROM ArticleEntity')
  Future<void> deleteAllArticles();

  @override
  @delete
  Future<void> deleteArticle(ArticleEntity articleEntity);

  @Query('SELECT EXISTS (SELECT 1 FROM ArticleEntity WHERE url = :url LIMIT 1)')
  @override
  Future<bool?> didArticleSave(String url);
}
