import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class ArticleEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? author;
  final String? title;
  final String? urlToImage;
  final String? publishedAt;

  const ArticleEntity({
    this.id,
    this.author,
    this.title,
    this.urlToImage,
    this.publishedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      author,
      title,
      urlToImage,
      publishedAt,
    ];
  }
}
