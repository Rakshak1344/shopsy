import 'package:app/features/products/data/models/product.dart';
import 'package:app/features/products/views/widgets/product_counter.dart';
import 'package:app/features/products/views/widgets/product_image.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductGridItem extends StatefulWidget {
  final Product product;

  const ProductGridItem({super.key, required this.product});

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
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
                    ProductImage(imageUrl: widget.product.imageUrl),
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
                    ProductCounter(product: widget.product),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods now access product via `widget.product`
  void _onTap(BuildContext context) {
    context.goNamed(
      AppRouteName.productDetail,
      queryParameters: {'productId': widget.product.id.toString()},
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
