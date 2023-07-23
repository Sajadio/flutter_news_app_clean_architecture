import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class AddHistoryNewsletterUserCase {
  final Repository _repo;

  AddHistoryNewsletterUserCase(this._repo);

  Future<void> call(List<Article> newsLetter) {
    return _repo.addNewsletterToSearchHistory(newsLetter);
  }
}
