import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/add_article_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_all_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/delete_article_use_case%20copy.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/did_article_save_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/local_article/get_all_saved_articles_use_case.dart';
import 'package:flutter_news_app_clean_architecture/locater/locater.dart';
import 'presentation/cubit/searchQuery/local_article_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/colors_app.dart';
import 'utils/config/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalArticleCubit>(
          create: (context) => LocalArticleCubit(
            locator<AddArticleCaseCase>(),
            locator<GetAllSavedArticlesUseCase>(),
            locator<DeleteAllArticlesUseCase>(),
            locator<DeleteArticleCaseCase>(),
            locator<DidArticleSaveUseCase>(),
          )..getAllSavedArticles(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: kPrimaryColor),
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
    );
  }
}
