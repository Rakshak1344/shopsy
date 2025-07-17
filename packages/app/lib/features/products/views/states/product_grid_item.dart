import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/views/states/product_counter.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductGridItem extends StatefulWidget {
  final Product product;

  const ProductGridItem({super.key, required this.product});

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  int _quantity = 0;

  /// Increments the quantity, respecting the available stock.
  void _increment() {
    if (_quantity < widget.product.availableQuantity) {
      setState(() => _quantity++);
      return;
    }

    // Show a snackbar if the user tries to exceed available stock
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You've reached the stock limit for this item."),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Decrements the quantity. The UI reverts to the 'Add' button at zero.
  void _decrement() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = widget.product.availableQuantity == 0;

    // Visually disable the card if the product is out of stock
    return Opacity(
      opacity: isOutOfStock ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: isOutOfStock ? null : () => _onTap(context),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _buildImage(),
                    const SizedBox(height: 12),
                    _buildTitle(context),
                    const SizedBox(height: 4),
                    _buildSubtitle(context),
                  ],
                ),
                // Use the new ProductCounter widget here
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${widget.product.price.toStringAsFixed(2)}"),
                    ProductCounter(
                      quantity: _quantity,
                      availableQuantity: widget.product.availableQuantity,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the "Add" button or the quantity counter based on the current state.
  Widget _buildAddOrCounterButton() {
    final bool isOutOfStock = widget.product.availableQuantity == 0;

    if (_quantity == 0) {
      return OutlinedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        onPressed: isOutOfStock ? null : _increment,

        style: OutlinedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          side: BorderSide(
            color:
                isOutOfStock
                    ? Colors.grey.shade400
                    : Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else {
      // The -/+ counter UI
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
              onPressed: _decrement,
              iconSize: 18,
              splashRadius: 20,
            ),
            Text(
              _quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _increment,
              iconSize: 18,
              splashRadius: 20,
            ),
          ],
        ),
      );
    }
  }

  /// Builds the network image with caching, placeholder, and error widgets.
  Widget _buildImage() {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: widget.product.imageUrl,
        height: 60,
        width: 60,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 300),
        progressIndicatorBuilder:
            (context, url, downloadProgress) => CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                strokeWidth: 2.0,
                color: Colors.grey[400],
              ),
            ),
        // Your existing error widget is perfect.
        errorWidget:
            (context, url, error) => CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey,
              ),
            ),
      ),
    );
  }

  // Helper methods now access product via `widget.product`
  void _onTap(BuildContext context) {
    context.goNamed(
      AppRouteName.productDetail,
      pathParameters: {'productId': widget.product.id.toString()},
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.product.name,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    var subtitleStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: const Color(0xff9791a8));

    return Text(
      widget.product.description,
      style: subtitleStyle,
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
