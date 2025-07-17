import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? size;

  const ProductImage({super.key, required this.imageUrl, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: size,
        width: size,
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
}
