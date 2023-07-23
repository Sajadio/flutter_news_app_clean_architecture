part of 'local_article_cubit.dart';

abstract class LocalArticleState extends Equatable {
  const LocalArticleState(
      {this.articles = const [], this.didArticleSave = false});

  final List<Article> articles;

  final bool didArticleSave;

  @override
  List<Object> get props => [];
}

class LocalArticleLoading extends LocalArticleState {}

class LocalArticleSuccess extends LocalArticleState {
  const LocalArticleSuccess(
      {super.articles = const [], super.didArticleSave = false}); 
}
