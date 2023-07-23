import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/add_items_to_search_history_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/delete_history_newletter_use_case.dart';
import 'package:flutter_news_app_clean_architecture/domain/usecase/history_newsletter/get_all_history_newsletter_use_case.dart';
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
            locator<AddHistoryNewsletterUserCase>(),
            locator<GetAllHistoryNewsletterCase>(),
            locator<DeleteHistoryNewsLetterUseCase>(),
          ),
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
