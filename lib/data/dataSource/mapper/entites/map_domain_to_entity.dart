import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

List<ArticleEntity> mapArticleDomainToArticleEntity(
  List<Article> articles,
) {
  return articles
      .map((Article article) => ArticleEntity(
            author: article.author,
            title: article.title,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt,
          ))
      .toList();
}
