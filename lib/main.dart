import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/utils/colors_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/config/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: kPrimaryColor),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }
}
