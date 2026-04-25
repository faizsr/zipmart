import 'package:go_router/go_router.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/features/auth/presentation/pages/login_page.dart';
import 'package:zipmart/src/features/cart/presentation/pages/cart_page.dart';
import 'package:zipmart/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:zipmart/src/features/splash/presentation/views/splash_page.dart';

class AppRouterConfig {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) => const CartPage(),
      ),
    ],
  );
}
