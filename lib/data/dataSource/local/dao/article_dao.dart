import 'package:floor/floor.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/history_newsletter_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';

@dao
abstract class ArticleDao implements LocalDataSource {
  @override
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addItemsToSearchHistory(
      List<HistoryNewsletterEntity> newsLetter);

  @override
  @Query('SELECT * FROM HistoryNewsletterEntity')
  Stream<List<HistoryNewsletterEntity>> getAllHistoryHistoryNewsletter();

  @override
  @Query('DELETE FROM HistoryNewsletterEntity')
  Future<void> deleteHistoryNewsLetter();
}
