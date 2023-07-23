import '../../repository/repository.dart';

class DeleteHistoryArticlesUseCase {
  final Repository _repo;

  DeleteHistoryArticlesUseCase(this._repo);

  Future<void> call() {
    return _repo.deleteHistoryArticles();
  }
}
