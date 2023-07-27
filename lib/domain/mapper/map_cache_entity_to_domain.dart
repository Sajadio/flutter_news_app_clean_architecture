import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/cache_article_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

List<Article> mapCacheArticleEntityToArticleDomain(
  List<CacheArticleEntity>? entities,
) {
  return entities != null
      ? entities
          .map((CacheArticleEntity entity) => Article(
              id: entity.id,
              author: entity.author,
              title: entity.title,
              urlToImage: entity.urlToImage,
              publishedAt: entity.publishedAt,
              description: entity.description,
              content: entity.content,
              url: entity.url))
          .toList()
      : List.empty();
}
