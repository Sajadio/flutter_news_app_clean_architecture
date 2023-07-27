import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? urlToImage;
  final String? publishedAt;
  final String? description;
  final String? url;
  final String? content;
  const Article({
    this.id,
    this.author,
    this.title,
    this.urlToImage,
    this.publishedAt,
    this.description,
    this.url,
    this.content,
  });

  @override
  List<Object?> get props => [
        id,
        author,
        title,
        urlToImage,
        publishedAt,
        content,
      ];
}
