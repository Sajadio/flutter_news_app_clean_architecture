import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int id;
  final String author;
  final String title;
  final String image;
  final String time;
  const Article({
    required this.id,
    required this.author,
    required this.title,
    required this.image,
    required this.time,
  });

  @override
  List<Object?> get props => [id, author, title, image, time];
}
