import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class RefreshCacheCaseCase {
  final Repository _repo;

  RefreshCacheCaseCase(this._repo);

  void call(String? category) {
    return _repo.refreshCacheData(category);
  }
}
