part of 'local_article_cubit.dart';

abstract class LocalArticleState extends Equatable {
  const LocalArticleState({this.articles = const []});

  final List<Article> articles;

  @override
  List<Object> get props => [];
}

class LocalArticleLoading extends LocalArticleState {}

class LocalArticleSuccess extends LocalArticleState {
  const LocalArticleSuccess({super.articles = const []});
}
