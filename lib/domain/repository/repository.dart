import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

abstract class Repository {
  Future<void> addNewsletterToSearchHistory(List<Article> articles);
  Stream<List<Article>> getAllHistoryHistoryNewsletter();
  Future<void> deleteHistoryNewsLetter();
}
