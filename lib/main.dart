import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/confic/theme/theme_manager.dart';
import 'package:flutter_news_app_clean_architecture/locator/locater.dart';
import 'presentation/cubit/searchQuery/article_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confic/router/app_router.dart';

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
    return  BlocProvider<ArticleCubit>(
      create: (context) => locator<ArticleCubit>(),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.lightTheme,
      ),
    );
  }
}
