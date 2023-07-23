import 'package:flutter_news_app_clean_architecture/data/dataSource/local/database/app_database.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/data/repository/repository_impl.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/add_items_to_search_history_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/delete_history_newletter_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/get_all_history_newsletter_use_case.dart';
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

  locator.registerSingleton<AddHistoryNewsletterUserCase>(
    AddHistoryNewsletterUserCase(locator<Repository>()),
  );

  locator.registerSingleton<GetAllHistoryNewsletterCase>(
    GetAllHistoryNewsletterCase(locator<Repository>()),
  );

  locator.registerSingleton<DeleteHistoryNewsLetterUseCase>(
    DeleteHistoryNewsLetterUseCase(locator<Repository>()),
  );
}
