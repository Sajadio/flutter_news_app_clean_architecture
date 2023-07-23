import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import '../../repository/repository.dart';

class GetAllHistoryNewsletterCase {
  final Repository _repo;

  GetAllHistoryNewsletterCase(this._repo);

  Stream<List<Article>> call() {
    return _repo.getAllHistoryHistoryNewsletter();
  }
}
