import 'package:app/navigation/route_provider.dart';
import 'package:app/navigation/router_notifier.dart';
import 'package:core/arch/app_config.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> goRouter(Ref ref) {
  var notifier = ref.read(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: AppConfig.navigatorKey,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    // observers: [],
    routes: AppRouter().routes(),
  );
}

class AppRouter {
  /// Our application routes. Obtained through code generation
  List<RouteBase> routes() =>
      routeProviders().fold([], (prev, e) => [...prev, ...e.routes()]);

  List<RouteProvider> routeProviders() {
    return [RoutesProvider()];
  }
}
