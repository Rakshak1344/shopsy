import 'package:flutter/material.dart';

class ProductCounter extends StatelessWidget {
  final int quantity;
  final int availableQuantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductCounter({
    super.key,
    required this.quantity,
    required this.availableQuantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = availableQuantity == 0;

    // When quantity is 0, show the 'Add' button.
    if (quantity == 0) {
      return SizedBox(
        height: 40,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add'),
          onPressed: isOutOfStock ? null : onIncrement,
          style: OutlinedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            side: BorderSide(
              color:
                  isOutOfStock
                      ? Colors.grey.shade400
                      : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }
    // Otherwise, show the counter UI.
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: onDecrement,
            iconSize: 18,
            splashRadius: 20,
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onIncrement,
            iconSize: 18,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
