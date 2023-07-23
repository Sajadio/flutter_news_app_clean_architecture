import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class HistoryNewsletterEntity extends Equatable {
  @primaryKey
  final int id;
  final String author;
  final String title;
  final String image;
  final String time;
  const HistoryNewsletterEntity({
    required this.id,
    required this.author,
    required this.title,
    required this.image,
    required this.time,
  });

  @override
  List<Object?> get props => [id, author, title, image, time];
}
