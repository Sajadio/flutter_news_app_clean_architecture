import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/source_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/source.dart';

List<ArticleEntity> mapArticleToArticleEntity(
  List<Article> articles,
) {
  return articles
      .map((Article article) => ArticleEntity(
            id: article.id,
            author: article.author,
            title: article.title,
            urlToImage: article.url,
            publishedAt: article.publishedAt,
            source: _mapSourceToSourceEntity(article.source),
            description: article.description,
            content: article.content,
            url: article.url,
          ))
      .toList();
}

SourceEntity _mapSourceToSourceEntity(Source? source) {
  return SourceEntity(id: source?.id, name: source?.name);
}
