import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

List<Article> mapArticleEntityToArticleDomain(
  List<ArticleEntity>? entities,
) {
  return entities != null
      ? entities
          .map((ArticleEntity entity) => Article(
                id: entity.id,
                author: entity.author,
                title: entity.title,
                urlToImage: entity.urlToImage,
                publishedAt: entity.publishedAt,
              ))
          .toList()
      : List.empty();
}
