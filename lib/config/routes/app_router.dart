import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gulf_sky_provider/core/utils/enums/payment_type.dart';
import 'package:gulf_sky_provider/features/presentation/views/buildings_by_type/buildings_by_type_view.dart';
import 'package:gulf_sky_provider/features/presentation/views/login/login_view.dart';
import 'package:gulf_sky_provider/features/presentation/views/notifications/notifications_view.dart';
import 'package:gulf_sky_provider/features/presentation/views/register/register_view.dart';

import '../../features/presentation/views/evacuation_request/evacuation_request_view.dart';
import '../../features/presentation/views/main/main_view.dart';
import '../../features/presentation/views/maintenance_request/maintenance_request_view.dart';
import '../../features/presentation/views/map/map_view.dart';
import '../../features/presentation/views/payment/payment_view.dart';
import '../../features/presentation/views/request/request_view.dart';
import '../../features/presentation/views/splash/splash_view.dart';
import 'app_routes.dart';

class AppRouter {
  static final List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.splashView,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.loginView,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutes.registerView,
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: AppRoutes.mainView,
      builder: (context, state) => const MainView(),
    ),
    GoRoute(
      path: AppRoutes.buildingsByTypeView,
      builder: (context, state) => const BuildingsByTypeView(),
    ),
    GoRoute(
      path: AppRoutes.requestView,
      builder: (context, state) => const RequestView(),
    ),
    GoRoute(
      path: AppRoutes.maintenanceRequestView,
      builder: (context, state) => const MaintenanceRequestView(),
    ),
    GoRoute(
      path: AppRoutes.evacuationRequestView,
      builder: (context, state) => const EvacuationRequestView(),
    ),
    GoRoute(
      path: AppRoutes.notificationsView,
      builder: (context, state) => const NotificationsView(),
    ),
    GoRoute(
      path: AppRoutes.mapView,
      builder: (context, state) => MapView(
        onBack: (state.extra as Map<String, dynamic>)['on_back'] as Function(LatLng),
        initialPosition: (state.extra as Map<String, dynamic>)['lat_lng'] as LatLng?,
      ),
    ),
    GoRoute(
      path: AppRoutes.paymentView,
      builder: (context, state) => PaymentView(
        id: (state.extra as Map<String, dynamic>)['id'] as int,
        price: (state.extra as Map<String, dynamic>)['price'] as num,
        paymentType: (state.extra as Map<String, dynamic>)['payment_type'] as PaymentType,
      ),
    ),
  ];
  static final router = GoRouter(
    routes: routes,
  );
}
