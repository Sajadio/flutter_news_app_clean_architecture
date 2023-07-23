import 'package:flutter_news_app_clean_architecture/data/dataSource/local/database/app_database.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/data/repository/repository_impl.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/add_article_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/add_articles_to_search_history_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_article_use_case%20copy.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_history_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/did_article_save_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_all_saved_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AppDatabase>(db);

  locator.registerSingleton<LocalDataSource>(db.articleDao);

  locator.registerSingleton<Repository>(
    RepositoryImpl(locator<LocalDataSource>()),
  );

  locator.registerSingleton<AddHistoryArticlesUseCase>(
    AddHistoryArticlesUseCase(locator<Repository>()),
  );

  locator.registerSingleton<GetAllHistoryArticlesUseCase>(
    GetAllHistoryArticlesUseCase(locator<Repository>()),
  );

  locator.registerSingleton<DeleteHistoryArticlesUseCase>(
    DeleteHistoryArticlesUseCase(locator<Repository>()),
  );

  locator.registerSingleton<DeleteArticleCaseCase>(
    DeleteArticleCaseCase(locator<Repository>()),
  );

  locator.registerSingleton<AddArticleCaseCase>(
    AddArticleCaseCase(locator<Repository>()),
  );
  locator.registerSingleton<DidArticleSaveUseCase>(
    DidArticleSaveUseCase(locator<Repository>()),
  );
}
