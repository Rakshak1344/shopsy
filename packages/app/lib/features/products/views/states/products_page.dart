import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/views/states/product_state.dart';
import 'package:app/features/products/views/states/products_list.dart';
import 'package:app/features/products/views/states/shimmer_list_tile.dart';
import 'package:core/error/no_more_data_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/utils/extensions/async_value_extension.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(productStateProvider.notifier).fetchProducts(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopsy")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildProductsOnState(),
      ),
    );
  }

  Widget buildProductsOnState() {
    var state = ref.watch(productStateProvider);

    return state.whenDataWithErrorFallback(
      loading: () {
        return state.hasValue && state.value!.isNotEmpty
            ? buildProducts(state.value!)
            : buildOnLoading();
      },
      data: buildProducts,
      emptyOrNull: () => buildOnEmpty(),
      error: (Object e, StackTrace s) {
        if (e is NoMoreDataException) {
          return buildOnEmpty();
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget buildProducts(List<Product> products) =>
      ProductsList(products: products);

  Widget buildOnEmpty() {
    return Card(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text("No products available"),
      ),
    );
  }

  Widget buildOnLoading() {
    return Card(
      child: ListView(
        children: List<ShimmerListTile>.generate(
          6,
          (_) => const ShimmerListTile(),
        ),
      ),
    );
  }
}
