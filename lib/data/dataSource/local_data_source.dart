import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/history_newsletter_entity.dart';

abstract class LocalDataSource {
  Future<void> addItemsToSearchHistory(
      List<HistoryNewsletterEntity> newsLetter);
  Stream<List<HistoryNewsletterEntity>> getAllHistoryHistoryNewsletter();
  Future<void> deleteHistoryNewsLetter();
}
