import 'package:flutter_news_app_clean_architecture/data/dataSource/remote/dto/article_dto.dart';


class NewsDto {
  final String status;
  final int totalResults;
  final List<ArticleDto> articles;

  NewsDto({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsDto.fromJson(Map<String, dynamic> json) {
    List<ArticleDto> articleList = List.from(json['articles'])
        .map((articleJson) => ArticleDto.fromJson(articleJson))
        .toList();

    return NewsDto(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articleList,
    );
  }
}
