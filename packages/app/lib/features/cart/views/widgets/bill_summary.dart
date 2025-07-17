import 'package:app/features/cart/views/state/cart_item_state.dart';
import 'package:app/features/products/views/states/product_detail_state.dart';
import 'package:core/utils/extensions/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillSummary extends ConsumerWidget {
  const BillSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartItemStateProvider).value ?? [];
    double total = 0;

    for (final item in cartItems) {
      final product =
          ref.watch(productDetailStateProvider(item.productId)).value;
      if (product != null) {
        total += item.quantity * product.price;
      }
    }

    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  total.formatAsCurrency(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Total Bill',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Paid Successfully")));
              },
              child: const Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
