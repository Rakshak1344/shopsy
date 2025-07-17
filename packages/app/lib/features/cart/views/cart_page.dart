import 'package:app/features/cart/data/models/cart_item.dart';
import 'package:app/features/cart/views/state/cart_item_state.dart';
import 'package:app/features/cart/views/widgets/bill_summary.dart';
import 'package:app/features/cart/views/widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsync = ref.watch(cartItemStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cartItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return buildEmpty();
          }

          return buildCartItems(items);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      // Bottom navigation bar for the bill summary and checkout button
      bottomNavigationBar:
          cartItemsAsync.value!.isNotEmpty ? const BillSummary() : null,
    );
  }

  Widget buildCartItems(List<CartItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartListItem(cartItem: items[index]);
      },
    );
  }

  Widget buildEmpty() {
    return const Center(
      child: Text(
        'Your cart is empty!',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
