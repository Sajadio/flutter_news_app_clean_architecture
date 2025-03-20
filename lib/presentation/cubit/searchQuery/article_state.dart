part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState({
    this.articles = const [],
    this.didArticleSave = false,
    this.errors,
  });

  final List<Article> articles;
  final bool didArticleSave;
  final String? errors;

  @override
  List<Object> get props => [];
}

class DataStateInitial extends ArticleState {}
class DataStateLoading extends ArticleState {}

class DataStateSuccess extends ArticleState {
  const DataStateSuccess({
    super.articles = const [],
  });
}

class DataStateFailure extends ArticleState {
  const DataStateFailure({super.errors});
}
