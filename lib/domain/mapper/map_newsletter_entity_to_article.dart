import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/source_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/source.dart';

List<Article> mapArticleEntityToArticles(
  List<ArticleEntity> articlesEntity,
) {
  return articlesEntity
      .map((ArticleEntity entity) => Article(
            id: entity.id,
            author: entity.author,
            title: entity.title,
            urlToImage: entity.url,
            publishedAt: entity.publishedAt,
            source: _mapSourceEntityToSource(entity.source),
            description: entity.description,
            content: entity.content,
            url: entity.url,
          ))
      .toList();
}

Source _mapSourceEntityToSource(SourceEntity? sourceEntity) {
  return Source(id: sourceEntity?.id, name: sourceEntity?.name);
}
