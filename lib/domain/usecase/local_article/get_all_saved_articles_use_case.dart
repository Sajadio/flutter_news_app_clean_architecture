import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import '../../repository/repository.dart';

class GetAllHistoryArticlesUseCase {
  final Repository _repo;

  GetAllHistoryArticlesUseCase(this._repo);

  Stream<List<Article>> call() {
    return _repo.getAllSavedArticles();
  }
}
