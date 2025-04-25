import 'package:auto_route/auto_route.dart';
import 'package:weather_app/routes/route_path.dart';
import 'package:weather_app/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route', deferredLoading: true)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [AutoRoute(initial: true, page: HomeRoute.page, path: RoutePath.rootPath)];
}
