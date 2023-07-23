import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/history_newsletter_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

List<HistoryNewsletterEntity> mapArticlesToHistoryNewsLetter(
  List<Article> articles,
) {
  return articles
      .map((Article article) => HistoryNewsletterEntity(
            id: article.id,
            author: article.author,
            title: article.title,
            image: article.image,
            time: article.time,
          ))
      .toList();
}
