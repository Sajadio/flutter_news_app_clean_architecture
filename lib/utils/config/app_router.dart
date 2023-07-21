import 'package:auto_route/auto_route.dart';
import '../../presentation/screens/details_screen.dart';
import '../../presentation/screens/search_screen.dart';

import '../../presentation/screens/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: DetailsRoute.page),
      ];
}
