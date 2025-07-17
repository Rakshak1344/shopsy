import 'package:app/features/products/views/product_detail_page.dart';
import 'package:app/features/products/views/products_page.dart';
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
        builder: (BuildContext context, GoRouterState state) => ProductsPage(),
        routes: [
          GoRoute(
            path: 'productDetail',
            name: AppRouteName.productDetail,
            builder: (BuildContext context, GoRouterState state) {
              var productId = int.tryParse(
                state.uri.queryParameters['productId'].toString(),
              );
              return ProductDetailPage(productId: productId);
            },
          ),
        ],
      ),
    ];
  }
}
