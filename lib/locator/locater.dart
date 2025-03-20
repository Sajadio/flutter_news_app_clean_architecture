import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/database/app_database.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/remote/service/api_service.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/remote_data_source.dart';
import 'package:flutter_news_app_clean_architecture/data/repository/repository_impl.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/add_article_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_article_use_case%20copy.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_all_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/did_article_save_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_all_saved_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_article_by_id_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_cache_data_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/refresh_cache_data_use_case.dart';
import 'package:flutter_news_app_clean_architecture/presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AppDatabase>(db);

  locator.registerSingleton<LocalDataSource>(db.articleDao);

  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  locator.registerSingleton<RemoteDataSource>(ApiService(dio));

  locator.registerSingleton<Repository>(
    RepositoryImpl(
      locator<LocalDataSource>(),
      locator<RemoteDataSource>(),
    ),
  );

  locator.registerSingleton<GetAllSavedArticlesUseCase>(
    GetAllSavedArticlesUseCase(locator<Repository>()),
  );

  locator.registerSingleton<DeleteAllArticlesUseCase>(
    DeleteAllArticlesUseCase(locator<Repository>()),
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

  locator.registerSingleton<GetArticleByIdUseCase>(
    GetArticleByIdUseCase(locator<Repository>()),
  );

  locator.registerSingleton<GetCacheCaseCase>(
    GetCacheCaseCase(locator<Repository>()),
  );

  locator.registerSingleton<RefreshCacheCaseCase>(
    RefreshCacheCaseCase(locator<Repository>()),
  );

  locator.registerFactory<ArticleCubit>(() => ArticleCubit(
        locator<AddArticleCaseCase>(),
        locator<GetAllSavedArticlesUseCase>(),
        locator<DeleteAllArticlesUseCase>(),
        locator<DeleteArticleCaseCase>(),
        locator<DidArticleSaveUseCase>(),
        locator<GetArticleByIdUseCase>(),
        locator<RefreshCacheCaseCase>(),
        locator<GetCacheCaseCase>(),
      ));
}
