import "package:frontend/src/pages/app_bottombar_controller.dart";
import 'package:go_router/go_router.dart';
import "../../pages/login_page.dart";
import "../../pages/splash_page.dart";

GoRouter router({String? initialLocation}) => GoRouter(
      initialLocation: initialLocation ?? Routes.splash,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) {
            return const SplashPage();
          },
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) {
            return AppBottomBarController();
          },
        ),
      ],
    );

class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
}
