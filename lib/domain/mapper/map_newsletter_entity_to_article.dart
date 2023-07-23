import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/history_newsletter_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

List<Article> mapHistoryNewsLettersToArticles(
  List<HistoryNewsletterEntity> newsLetterEntities,
) {
  return newsLetterEntities
      .map((HistoryNewsletterEntity newsLetter) => Article(
            id: newsLetter.id,
            author: newsLetter.author,
            title: newsLetter.title,
            image: newsLetter.image,
            time: newsLetter.time,
          ))
      .toList();
}
