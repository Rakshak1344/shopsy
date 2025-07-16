import 'package:app/navigation/app_route_name.dart';
import 'package:core/arch/navigation/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesProvider extends RouteProvider {
  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: '/',
        name: AppRouteName.root,
        builder:
            (BuildContext context, GoRouterState state) =>
                Scaffold(appBar: AppBar(title: Text("Shopsy"))),
        routes: [],
      ),
    ];
  }
}
