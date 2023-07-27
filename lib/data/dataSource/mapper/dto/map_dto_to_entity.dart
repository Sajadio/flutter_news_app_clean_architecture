import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/cache_article_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/remote/dto/article_dto.dart';

List<CacheArticleEntity> mapArticleDtoToCacheArticleEntity(
  List<ArticleDto> articlesDto,
  String? category,
) {
  return articlesDto
      .map(
        (ArticleDto dto) => CacheArticleEntity(
            author: dto.author,
            title: dto.title,
            urlToImage: dto.urlToImage,
            publishedAt: dto.publishedAt,
            description: dto.description,
            content: dto.content,
            url: dto.url,
            category: category),
      )
      .toList();
}
