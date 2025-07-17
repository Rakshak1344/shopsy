import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/views/widgets/product_grid_item.dart';
import 'package:app/features/products/views/states/product_state.dart';
import 'package:core/error/no_more_data_exception.dart';
import 'package:core/ui/widgets/paginated_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsList extends ConsumerStatefulWidget {
  final List<Product> products;

  const ProductsList({super.key, required this.products});

  @override
  ConsumerState<ProductsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends ConsumerState<ProductsList> {
  int page = 1;
  bool hasMore = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    listenTransactionState();

    return PaginatedGridView<Product>(
      items: widget.products,
      onRefresh: onPullToRefreshProducts,
      updatePageNumber: (int? value) async {
        page++;
        await fetchProducts();
      },
      noMoreItemsText: "No more products available",
      buildItem: (Product product) => ProductGridItem(product: product),
      hasMore: hasMore,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        mainAxisSpacing: 8.0, // Vertical spacing
        crossAxisSpacing: 8.0, // Horizontal spacing
        childAspectRatio: 0.8, // Aspect ratio of the items
      ),
    );
  }

  Future<void> onPullToRefreshProducts() async {
    page = 1;
    hasMore = true;
    await ref.read(productStateProvider.notifier).fetchProducts();
  }

  void listenTransactionState() {
    ref.listen(productStateProvider, (
      previous,
      AsyncValue<List<Product>> next,
    ) {
      if (next.error is NoMoreDataException) {
        setState(() => hasMore = false);

        return;
      }
    });
  }

  Future<void> fetchProducts() async {
    await ref.read(productStateProvider.notifier).fetchProducts(page);
  }
}
