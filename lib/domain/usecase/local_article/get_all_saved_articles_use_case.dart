import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import '../../repository/repository.dart';

class GetAllSavedArticlesUseCase {
  final Repository _repo;

  GetAllSavedArticlesUseCase(this._repo);

  Stream<List<Article>> call() {
    return _repo.getAllSavedArticles();
  }
}
