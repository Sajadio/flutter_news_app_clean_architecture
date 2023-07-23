import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class AddHistoryArticlesUseCase {
  final Repository _repo;

  AddHistoryArticlesUseCase(this._repo);

  Future<void> call(List<Article> articles) {
    return _repo.addArticlesToSearchHistory(articles);
  }
}
